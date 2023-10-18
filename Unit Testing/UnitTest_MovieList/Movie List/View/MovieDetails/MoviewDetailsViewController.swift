//
//  MoviewDetailsViewController.swift
//  Movie List
//
//  Created by Muhammad Ariful islam on 17/10/23.
//

import UIKit

class MoviewDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var addToCartButton: UIButton!
    
    var viewModel: MovieViewModel?
    var selectedItem: Int?
    var movieInfo: MovieResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieInfo = viewModel?.getMovieDetail(from: selectedItem ?? 0)
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel?.moviewDetailsVCBackButtonTap()
    }
    
    private func setupUI() {
        if let imageUrl = movieInfo?.posterUrl {
            imageView.loadImage(fromUrl: imageUrl)
        }
        
        headlineLabel.text = movieInfo?.title
        detailTextView.text = movieInfo?.overview
        addToCartButton.layer.cornerRadius = 10
        
        if movieInfo?.isAddedOnCart ?? false {
            addToCartButton.isEnabled = false
            addToCartButton.setTitle("Already added to favorite list", for: .normal)
        } else {
            addToCartButton.isEnabled = true
            addToCartButton.setTitle("Add to favorite list", for: .normal)
        }
    }
    
    @IBAction func addToCartTap(_ sender: Any) {
        if !(movieInfo?.isAddedOnCart ?? false)  {
            addToCartButton.isEnabled = false
            addToCartButton.setTitle("Already added to favorite list", for: .normal)
            viewModel?.setAddItemToTheCartPropertTrue(for: selectedItem ?? 0)
            viewModel?.addMovieItemOnCart(usign: selectedItem ?? 0)
        }
    }
}
