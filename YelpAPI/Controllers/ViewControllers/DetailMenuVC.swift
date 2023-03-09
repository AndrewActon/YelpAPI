//
//  DetailMenuVC.swift
//  YelpAPI
//
//  Created by Andrew Acton on 3/2/23.
//

import UIKit

protocol DetailMenuDelegate {
    func updateTally()
}

class DetailMenuVC: UIViewController {

    //MARK: - Properties
    var business: Business?
    var delegate: DetailMenuDelegate?
    
    //MARK: - Outlets
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailPriceLabel: UILabel!
    @IBOutlet weak var detailRatingLabel: UILabel!
    @IBOutlet weak var detailCategoriesLabel: UILabel!
    
    
    
    //MARK: - Lifecylce Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: - Helper Methods
    
    func isOpen () -> String {
        if business?.isClosed == true {
            return "False"
        } else {
            return "True"
        }
    }
    
    func updateViews() {
        guard let business = business else { return }
        detailImageView.load(url: business.imageURL)
        detailNameLabel.text = business.name
        detailPriceLabel.text = business.price
        detailRatingLabel.text = "\(business.rating)"
        
        var categoriesArray: [String] = []
        for category in business.categories {
            categoriesArray.append(category.alias)
        }
        let categories = categoriesArray.joined(separator: ", ")
        
        detailCategoriesLabel.text = categories
    }
    
    //MARK: - Actions
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func detailCallButtonTapped(_ sender: Any) {
        
    }
    @IBAction func detailViewMapButtonTapped(_ sender: Any) {
        
    }
    @IBAction func detailReviewsButtonTapped(_ sender: Any) {
        
    }
    @IBAction func detailAddToCartButtonTapped(_ sender: Any) {
        delegate?.updateTally()
    }


}
