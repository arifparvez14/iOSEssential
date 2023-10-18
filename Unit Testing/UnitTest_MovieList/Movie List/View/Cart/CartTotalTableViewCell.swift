//
//  CartTotalTableViewCell.swift
//  Movie List
//
//  Created by Muhammad Ariful islam on 18/10/23.
//

import UIKit

class CartTotalTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var totalDuration: UILabel!
    @IBOutlet weak var totalCount: UILabel!
    
    func setupCell(movieCount: Int, movieDuration: Int) {
        containerView.layer.cornerRadius = 10
        totalCount.text = "Total Movie: \(movieCount)"
        totalDuration.text = "Duration: \(movieDuration)"
    }
}
