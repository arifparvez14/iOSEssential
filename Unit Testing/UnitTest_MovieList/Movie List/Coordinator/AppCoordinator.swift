//
//  AppCoordinator.swift
//  Movie List
//
//  Created by Muhammad Ariful islam on 17/10/23.
//

import UIKit

class AppCoordinator: Coordinator {

    fileprivate let HOME_KEY: String = "Home"
    
    var navigationController: UINavigationController
    var coordinator = [String: Coordinator]()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showHome()
    }
    
    private func showHome() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        coordinator[HOME_KEY] = homeCoordinator
        homeCoordinator.delegate = self
        homeCoordinator.start()
    }
}

extension AppCoordinator: HomeCoordinatorDelegate {
    func homeCoordinatorDidFinish(homeCoordinator: HomeCoordinator) {
        coordinator[HOME_KEY] = nil
    }
}

