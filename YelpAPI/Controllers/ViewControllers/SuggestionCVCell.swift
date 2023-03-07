//
//  SuggestionCVCell.swift
//  YelpAPI
//
//  Created by Andrew Acton on 2/27/23.
//

import UIKit

class SuggestionCVCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var suggestionImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    
    func updateViews(business: Business?) {
        guard let business = business else { return }
        nameLabel.text = business.name
        ratingLabel.text = "Rating: \(business.rating)"
        priceLabel.text = business.price
//        suggestionImage.image = business.imageURL
    }
}
