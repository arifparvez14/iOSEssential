//
//  AppCoordinator.swift
//  Movie List
//
//  Created by Muhammad Ariful islam on 17/10/23.
//

import UIKit

class AppCoordinator: Coordinator {

    fileprivate let HOME_KEY: String = "Home"
    fileprivate let AUTH_KEY: String = "Auth"
    
    var navigationController: UINavigationController
    var coordinator = [String: Coordinator]()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        //let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        let isLoggedIn = false
        isLoggedIn ? showHome() : showAuth()
    }
    
    private func showAuth() {
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        coordinator[AUTH_KEY] = authCoordinator
        authCoordinator.delegate = self
        authCoordinator.start()
    }
    
    private func showHome() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        coordinator[HOME_KEY] = homeCoordinator
        homeCoordinator.delegate = self
        homeCoordinator.start()
    }
}

extension AppCoordinator: AuthCoordinatorDelegate {
    func authCoordinatorDidFinish(authCoordinator: AuthCoordinator) {
        coordinator[AUTH_KEY] = nil
        showHome()
    }
}

extension AppCoordinator: HomeCoordinatorDelegate {
    func homeCoordinatorDidFinish(homeCoordinator: HomeCoordinator) {
        coordinator[HOME_KEY] = nil
    }
}

