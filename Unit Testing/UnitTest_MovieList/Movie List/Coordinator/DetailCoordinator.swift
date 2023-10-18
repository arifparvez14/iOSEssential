//
//  MovieDetailCoordinator.swift
//  Movie List
//
//  Created by Muhammad Ariful islam on 17/10/23.
//

import UIKit

protocol DetailCoordinatorDelegate: AnyObject {
    func detailCoordinatorDidFinish(detailCoordinator: DetailCoordinator)
}

class DetailCoordinator: Coordinator {
    
    weak var delegate: DetailCoordinatorDelegate?
    var viewModel: MovieViewModel
    let selectedItem: Int
    var navigationController: UINavigationController
    
    init(viewModel: MovieViewModel, selectedItem: Int, navigationController: UINavigationController) {
        self.viewModel = viewModel
        self.selectedItem = selectedItem
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "MoviewDetailsViewController") as? MoviewDetailsViewController {
            viewModel.detailCoordinatorDelegate = self
            vc.viewModel = viewModel
            vc.selectedItem = selectedItem
            navigationController.pushViewController(vc, animated: true)
        }
    }
}

extension DetailCoordinator: MovieDetailCoordinatorDelegate {
    func detailCoordinatorDidFinish(viewModel: MovieViewModel) {
        delegate?.detailCoordinatorDidFinish(detailCoordinator: self)
    }
}


