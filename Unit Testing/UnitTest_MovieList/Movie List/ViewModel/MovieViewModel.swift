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

protocol MovieViewModelProtocol {
    var movieList: Bindable<[MovieResult]> { get }
    var movieListFetchStatus: Bindable<Bool> { get }
    func searchMovie(withQueryString query: String?)
    var coordinatorDelegate: MovieViewModelCoordinationDelegate? { get set }
    var detailCoordinatorDelegate: MovieDetailCoordinatorDelegate? { get set }
    func didTapOnMovieItem(index: Int)
    func getMovieDetail(from selectedIndex: Int) -> MovieResult
    func moviewDetailsVCBackButtonTap()
    func addMovieItemOnCart(usign index: Int)
}

class MovieViewModel: MovieViewModelProtocol {
    
    var movieListFetchStatus: Bindable<Bool> = Bindable(false)
    var movieList: Bindable<[MovieResult]> = Bindable([])
    var clientService: ClientServiceProtocol
    weak var coordinatorDelegate: MovieViewModelCoordinationDelegate?
    weak var detailCoordinatorDelegate: MovieDetailCoordinatorDelegate?
    
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
                    returnMovie.duration = Int.random(in: 100..<140)
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
    
    func addMovieItemOnCart(usign index: Int) {
        CartManager.sharedInstance.add(movieResult: movieList.value[index])
    }
}
