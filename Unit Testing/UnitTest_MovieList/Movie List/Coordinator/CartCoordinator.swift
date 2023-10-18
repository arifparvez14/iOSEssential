//
//  CartCoordinator.swift
//  Movie List
//
//  Created by Muhammad Ariful islam on 17/10/23.
//

import UIKit

protocol CartCoordinatorDelegate: AnyObject {
    func cartCoordinatorDidFinish(cartCoordinator: CartCoordinator)
}

class CartCoordinator: Coordinator {

    var navigationController: UINavigationController
    var viewModel: MovieViewModel
    weak var delegate: CartCoordinatorDelegate?

    init(viewModel: MovieViewModel, navigationController: UINavigationController) {
        self.viewModel = viewModel
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            viewModel.cartCoordinatorDelegate = self
            vc.viewModel = viewModel
            navigationController.pushViewController(vc, animated: true)
        }
    }
}

extension CartCoordinator: MovieCartCoordinatorDelegate {
    func cartCoordinatorDidFinish(viewModel: MovieViewModel) {
        print("Cart coordination did finish")
        delegate?.cartCoordinatorDidFinish(cartCoordinator: self)
    }
}

