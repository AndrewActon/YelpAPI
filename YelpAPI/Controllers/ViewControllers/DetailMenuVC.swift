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
    let mapURL = URL(string: "https://maps.apple.com/")
    
    //MARK: - Outlets
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailPriceLabel: UILabel!
    @IBOutlet weak var detailRatingLabel: UILabel!
    @IBOutlet weak var detailCategoriesLabel: UILabel!
    @IBOutlet weak var isOpenLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    
    
    //MARK: - Lifecylce Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        isOpen()
    }
    
    //MARK: - Helper Methods
    
    func isOpen () {
        if business?.isClosed == true {
            isOpenLabel.text = "Closed"
            isOpenLabel.textColor = .systemRed
        } else {
            isOpenLabel.text = "Open Now"
            isOpenLabel.textColor = .systemGreen
        }
    }
    
    func setStars (rating: Double) -> String {
        var stars = ""
        
        switch rating.rounded(.towardZero) {
        case 1:
            stars = "⭐️"
        case 2:
            stars = "⭐️⭐️"
        case 3:
            stars = "⭐️⭐️⭐️"
        case 4:
            stars = "⭐️⭐️⭐️⭐️"
        case 5:
            stars = "⭐️⭐️⭐️⭐️⭐️"
        default:
            break
        }
        
        return stars
    }
    
    func updateViews() {
        guard let business = business else { return }
        detailImageView.load(url: business.imageURL)
        detailNameLabel.text = business.name
        detailPriceLabel.text = business.price
        
        let stars = setStars(rating: business.rating)
        detailRatingLabel.text = stars
        
        var categoriesArray: [String] = []
        for category in business.categories {
            categoriesArray.append(category.alias)
        }
        let categories = categoriesArray.joined(separator: ", ")
        
        detailCategoriesLabel.text = categories
        
        addToCartButton.layer.cornerRadius = 15
    }
    
    //MARK: - Actions
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func detailCallButtonTapped(_ sender: Any) {
        guard let phoneNumber = business?.phone,
            let url = URL(string: "tel:\(phoneNumber)") else { return }
        print("Calling: \(phoneNumber)")
        UIApplication.shared.open(url)
    }
    
    @IBAction func detailViewMapButtonTapped(_ sender: Any) {
        guard let business = business,
        let mapURL = mapURL
        else { return }
        
        let displayAddress = business.location.displayAddress
        let searchAddress = displayAddress.joined()
        
        var components = URLComponents(url: mapURL, resolvingAgainstBaseURL: true)
        
        components?.queryItems = [URLQueryItem(name: "address", value: searchAddress)]
        
        guard let componentsURL = components?.url else { return }
        print(componentsURL)
        
        UIApplication.shared.open(componentsURL)
    }
    
    @IBAction func detailReviewsButtonTapped(_ sender: Any) {
        guard let business = business,
              let url = URL(string: business.url)
        else { return }
        print(business.url)
        UIApplication.shared.open(url)
    }
    
    @IBAction func detailAddToCartButtonTapped(_ sender: Any) {
        delegate?.updateTally()
    }

}
