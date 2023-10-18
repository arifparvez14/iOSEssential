//
//  MovieViewModel.swift
//  Movie List
//

import UIKit


protocol MovieViewModelCoordinationDelegate: AnyObject {
    func didTapOnCart(viewModel: MovieViewModel)
    func didTapOnMovie(viewModel: MovieViewModel, selectedItem: Int)
}

protocol MovieDetailCoordinatorDelegate: AnyObject {
    func detailCoordinatorDidFinish(viewModel: MovieViewModel)
}

protocol MovieCartCoordinatorDelegate: AnyObject {
    func cartCoordinatorDidFinish(viewModel: MovieViewModel)
}

protocol MovieViewModelProtocol {
    var movieList: Bindable<[MovieResult]> { get }
    var movieListFetchStatus: Bindable<Bool> { get }
    func searchMovie(withQueryString query: String?)
    var coordinatorDelegate: MovieViewModelCoordinationDelegate? { get set }
    var detailCoordinatorDelegate: MovieDetailCoordinatorDelegate? { get set }
    var cartCoordinatorDelegate: MovieCartCoordinatorDelegate? { get set }
    func didTapOnMovieItem(index: Int)
    func getMovieDetail(from selectedIndex: Int) -> MovieResult
    func moviewDetailsVCBackButtonTap()
    func addMovieItemOnCart(usign index: Int)
    func didTapOnCart()
    func cartVCBackButtonTap()
    func getCartItems()
    func removeCartItems(movieResult: MovieResult)
    var cartItems: [MovieResult] { get }
    func getMovieResultItem(by index: Int) -> MovieResult
}

class MovieViewModel: MovieViewModelProtocol {
    
    var movieListFetchStatus: Bindable<Bool> = Bindable(false)
    var movieList: Bindable<[MovieResult]> = Bindable([])
    var clientService: ClientServiceProtocol
    
    weak var coordinatorDelegate: MovieViewModelCoordinationDelegate?
    weak var detailCoordinatorDelegate: MovieDetailCoordinatorDelegate?
    weak var cartCoordinatorDelegate: MovieCartCoordinatorDelegate?
    var cartItems: [MovieResult] = [MovieResult]()
    
    
    init(clientService: ClientServiceProtocol) {
        self.clientService = clientService
    }

    func searchMovie(withQueryString query: String?) {
        Log.info("Search movie with query string - \(String(describing: query))")
        self.clientService.searchMovie(query: query) { [weak self] movieList in
            guard let `self` = self else { return }
            switch movieList {
            case .success(let list):
                self.movieList.value = list.results.map({ (movie) -> MovieResult in
                    var returnMovie = movie
                    returnMovie.cellHeight = self.calculateCellHeight(forItem: movie)
                    returnMovie.posterUrl = URL(string: baseImageUrl + (returnMovie.posterPath ?? "")) ?? nil
                    returnMovie.isAddedOnCart = false
                    returnMovie.duration = Int.random(in: 100..<160)
                    return returnMovie
                })
                self.movieListFetchStatus.value = true

            case .failure(let error):
                self.movieListFetchStatus.value = false
                Log.info(error.localizedDescription)
            }
        }
    }

    private func calculateCellHeight(forItem item: MovieResult) -> CGFloat {
        let labelWidth = UIScreen.main.bounds.width - posterImageWidth - 68     //68 = 3*16 (item gap) + 20 (safe area)
        let overViewLabelFont = UIFont.systemFont(ofSize: labelFontSize)
        let titleLabelFont = UIFont.boldSystemFont(ofSize: labelFontSize)
        let overViewLabelHeight = item.overview?.height(withConstrainedWidth: labelWidth, font: overViewLabelFont)
        let titleLabelHeight = item.title?.height(withConstrainedWidth: labelWidth, font: titleLabelFont)
        let totalHeight = titleLabelHeight! + overViewLabelHeight! + 40     //40 = 3*10 (item gap) + 10 padding
        return totalHeight > defaultCellHeight ? totalHeight : defaultCellHeight
    }
    
    func didTapOnMovieItem(index: Int) {
        coordinatorDelegate?.didTapOnMovie(viewModel: self, selectedItem: index)
    }
    
    func getMovieDetail(from selectedIndex: Int) -> MovieResult {
        return movieList.value[selectedIndex]
    }
    
    func setAddItemToTheCartPropertTrue(for index: Int) {
        movieList.value[index].isAddedOnCart = true
    }
    
    func moviewDetailsVCBackButtonTap() {
        detailCoordinatorDelegate?.detailCoordinatorDidFinish(viewModel: self)
    }
    

    func addMovieItemOnCart(usign id: Int) {
        for item in movieList.value {
            if item.id == id {
                CartManager.sharedInstance.add(movieResult: item)
                break
            }
        }
    }
    
    //Cart functionality
    func didTapOnCart() {
        coordinatorDelegate?.didTapOnCart(viewModel: self)
    }
    
    func cartVCBackButtonTap() {
        cartCoordinatorDelegate?.cartCoordinatorDidFinish(viewModel: self)
    }
    
    func getCartItems(){
        cartItems = CartManager.sharedInstance.getCartItems()
    }
    
    func removeCartItems(movieResult: MovieResult) {
        CartManager.sharedInstance.remove(movieResult: movieResult)
    }
    
    func getMovieResultItem(by index: Int) -> MovieResult {
        return self.cartItems[index]
    }
    
    func getTotalCountAndDuration() -> (count: Int, duration: Int) {
        var count = 0
        var duration = 0
        
        for item in cartItems {
            count = count + 1
            duration = duration + (item.duration ?? 0)
        }
        
        return(count: count, duration: duration)
    }
}
