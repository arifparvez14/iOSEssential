//
//  HomeCoordinator.swift
//  Movie List
//
//  Created by Muhammad Ariful islam on 17/10/23.
//

import UIKit

protocol HomeCoordinatorDelegate: AnyObject {
    func homeCoordinatorDidFinish(homeCoordinator: HomeCoordinator)
}

class HomeCoordinator: Coordinator {

    weak var delegate: HomeCoordinatorDelegate?
    let navigationController: UINavigationController
    var viewModel = MovieViewModel(clientService: ClientService())
    var detailcoordinator: DetailCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            vc.viewModel = viewModel
            viewModel.coordinatorDelegate = self
            navigationController.pushViewController(vc, animated: true)
        }
    }
}

extension HomeCoordinator: MovieViewModelCoordinationDelegate {
    func didTapOnCart(viewModel: MovieViewModel) {
        print("Cart Tapped")
    }
    
    func didTapOnMovie(viewModel: MovieViewModel, selectedItem: Int) {
        detailcoordinator = DetailCoordinator(viewModel: self.viewModel, selectedItem: selectedItem, navigationController: self.navigationController)
        detailcoordinator?.delegate = self
        detailcoordinator?.start()
    }
}

extension HomeCoordinator: DetailCoordinatorDelegate {
    func detailCoordinatorDidFinish(detailCoordinator: DetailCoordinator) {
        print("Detail coordinator back button pressed")
    }
}