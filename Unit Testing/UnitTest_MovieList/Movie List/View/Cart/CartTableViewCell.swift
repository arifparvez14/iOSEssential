//
//  CartTableViewCell.swift
//  Movie List
//
//  Created by Muhammad Ariful islam on 18/10/23.
//

import UIKit

protocol CartTableViewCellDelegate: AnyObject {
    func didTapOnDeleteButton(movieResult: MovieResult)
}

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var thumbnelView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    weak var delegate: CartTableViewCellDelegate?
    
    var movieResult: MovieResult?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func configCell(movieResult: MovieResult) {
        self.movieResult = movieResult
        setupCell()
    }
    
    private func setupCell() {
        containerView.layer.cornerRadius = 10
        
        if let imageUrl = movieResult?.posterUrl {
            thumbnelView.loadImage(fromUrl: imageUrl)
        }
        
        durationLabel.text = movieResult?.overview
        movieTitleLabel.text = movieResult?.title
        
    }
    
    @IBAction func deleteButtonTap(_ sender: Any) {
        if let movieResult = self.movieResult {
            delegate?.didTapOnDeleteButton(movieResult: movieResult)
        }
    }
}
