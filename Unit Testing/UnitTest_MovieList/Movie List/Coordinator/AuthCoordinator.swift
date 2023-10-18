//
//  AuthCoordinator.swift
//  Movie List
//
//  Created by Muhammad Ariful islam on 18/10/23.
//

import UIKit

protocol AuthCoordinatorDelegate: AnyObject {
    func authCoordinatorDidFinish(authCoordinator: AuthCoordinator)
}

class AuthCoordinator: Coordinator {
    
    weak var delegate: AuthCoordinatorDelegate?
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "AuthViewController") as? AuthViewController {
            let viewModel = AuthViewModel(authValidator: AuthValidator())
            vc.viewModel = viewModel
            viewModel.coordinatorDelegate = self
            navigationController.pushViewController(vc, animated: true)
        }
    }
}

extension AuthCoordinator: AuthCoordinationDelegate {
    func authCoordinatorDidFinish(viewModel: AuthViewModel) {
        delegate?.authCoordinatorDidFinish(authCoordinator: self)
    }
}
