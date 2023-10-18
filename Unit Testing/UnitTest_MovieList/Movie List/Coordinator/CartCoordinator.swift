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

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        listViewController = storyboard.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController
//            
//        guard let listViewController = listViewController else { return }
//        
//        let viewModel = MVVMCListViewModel()
//        viewModel.model = ListModel()
//        viewModel.coordinatorDelegate = self
//        listViewController.viewModel = viewModel
//        navigationController.pushViewController(listViewController, animated: true)
        
    }
}
//
//extension ListCoordinator: ListViewModelCoordinatorDelegate {
//    func listViewModelDidSelectData(_ viewModel: ListViewModel, data: DataItem) {
//        detailCoordinator = DetailCoordinator(dataItem: data, navigationController: navigationController)
//        detailCoordinator?.delegate = self
//        detailCoordinator?.start()
//    }
//}
//
//extension ListCoordinator: DetailCoordinatorDelegate {
//    func detailCoordinatorDidFinish(detailCoordinator: DetailCoordinator) {
//        self.detailCoordinator = nil
//        navigationController.popViewController(animated: true)
//    }
//}
