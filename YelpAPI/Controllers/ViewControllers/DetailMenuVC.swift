//
//  DetailMenuVC.swift
//  YelpAPI
//
//  Created by Andrew Acton on 3/2/23.
//

import UIKit

class DetailMenuVC: UIViewController {

    //MARK: - Properties
    var business: Business?
    
    //MARK: - Outlets
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailPriceAndCategoriesLabel: UILabel!
    @IBOutlet weak var detailRatingLabel: UILabel!
    
    //MARK: - Lifecylce Methods
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Actions
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        
    }
    @IBAction func detailCallButtonTapped(_ sender: Any) {
        
    }
    @IBAction func detailViewMapButtonTapped(_ sender: Any) {
        
    }
    @IBAction func detailReviewsButtonTapped(_ sender: Any) {
        
    }
    @IBAction func detailAddToCartButtonTapped(_ sender: Any) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
