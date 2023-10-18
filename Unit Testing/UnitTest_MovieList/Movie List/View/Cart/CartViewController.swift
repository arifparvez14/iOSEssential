//
//  CartViewController.swift
//  Movie List
//
//  Created by Muhammad Ariful islam on 18/10/23.
//

import UIKit

enum CellType {
    case movieItem
    case totalMovie
}

class CartViewController: UIViewController {
    
    @IBOutlet weak var cartTableView: UITableView!
    var viewModel: MovieViewModel?
    private var cellType = [CellType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        viewModel?.getCartItems()
        prepareCellData()
        CartManager.sharedInstance.add(subscriber: self)
    }
    
    private func setUpTableView() {
        cartTableView.delegate = self
        cartTableView.dataSource = self
        cartTableView.register(UINib(nibName: cartTableViewCellName, bundle: nil), forCellReuseIdentifier: cartTableViewCellName)
        cartTableView.register(UINib(nibName: cartTotalTableViewCellName, bundle: nil), forCellReuseIdentifier: cartTotalTableViewCellName)
    }
    
    private func prepareCellData() {
        if let cartItems = viewModel?.cartItems, cartItems.count > 0 {
            for _ in cartItems {
                cellType.append(.movieItem)
            }
            
            cellType.append(.totalMovie)
        } else {
            cellType.removeAll()
        }
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = self.cellType[indexPath.row]
        
        switch cellType {
        case .movieItem:
            let cellObject = tableView.dequeueReusableCell(withIdentifier: cartTableViewCellName, for: indexPath)
            guard let cell = cellObject as? CartTableViewCell else {
                return UITableViewCell()
            }

            if let movieResult = viewModel?.getMovieDetail(from: indexPath.row) {
                cell.configCell(movieResult: movieResult)
            }
        
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        case .totalMovie:
            let cellObject = tableView.dequeueReusableCell(withIdentifier: cartTotalTableViewCellName, for: indexPath)
            guard let cell = cellObject as? CartTotalTableViewCell else {
                return UITableViewCell()
            }
            
            if let countAndDurationValue = viewModel?.getTotalCountAndDuration() {
                cell.setupCell(movieCount: countAndDurationValue.count, movieDuration: countAndDurationValue.duration)
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellType = self.cellType[indexPath.row]
        
        switch cellType {
        case .movieItem:
            return 150
        case .totalMovie:
            return 100
        }
    }
}

extension CartViewController: CartSubscriber {
    func accept(changed cartCount: Int) {
        viewModel?.getCartItems()
        prepareCellData()
        cartTableView.reloadData()
    }
}

extension CartViewController: CartTableViewCellDelegate{
    func didTapOnDeleteButton(movieResult: MovieResult) {
        viewModel?.removeCartItems(movieResult: movieResult)
    }
}
