//
//  HomeView.swift
//  YelpAPI
//
//  Created by Andrew Acton on 2/27/23.
//

import UIKit

class HomeView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, DetailMenuDelegate {
    
    //MARK: - Properties
    var businessess: [Business?] = [] {
        didSet {
            DispatchQueue.main.async {
                self.suggestionCollectionView.reloadData()
                print(self.businessess.count)
            }
        }
    }
    var tally: Int = 0

    //MARK: - Outlets
    @IBOutlet weak var popularLabel: UILabel!
    @IBOutlet weak var suggestionCollectionView: UICollectionView!
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var orderNowButton: UIButton!
    @IBOutlet weak var driverImage: UIImageView!
    @IBOutlet weak var foodCategoriesLabel: UILabel!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    
    
    
    
    
    //MARK: - Lifecylce Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        suggestionCollectionView.delegate = self
        suggestionCollectionView.dataSource = self
        fetchPopular()
        updateViews()
    }
    
    //MARK: - Helper Methods
    func fetchPopular() {
        BusinessController.shared.fetchBusiness(searchTerm: "popular food") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let bussiness):
                    self.businessess = bussiness
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
                }
            }
        }
    }
    
    func updateTally() {
        tally += 1
        updateViews()
    }
    
    func updateViews() {
        popularLabel.text = "Popular"
        locationLabel.text = "Layton, UT"
        locationImage.image = UIImage(systemName: "location")
        if tally == 0 {
            orderNowButton.setTitle("No Orders", for: .normal)
        } else {
            orderNowButton.setTitle("Order Now \(tally)", for: .normal)
        }
    }
    
    //MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoriesCollectionView {
            return CategoryOptions.categories.count
        } else if collectionView == suggestionCollectionView {
            return businessess.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoriesCollectionView {
            guard let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "categoriesCell", for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
            #warning("start here")
                    
        } else if collectionView == suggestionCollectionView {
            guard let cell = suggestionCollectionView.dequeueReusableCell(withReuseIdentifier: "suggestionCell", for: indexPath) as? SuggestionCVCell,
                  
                    let bussiness = businessess[indexPath.row]
                    
            else { return UICollectionViewCell() }
            
            
            cell.updateViews(business: bussiness)
            cell.suggestionImage.load(url: bussiness.imageURL)
            
            return cell
        }
    }
    
     
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailMenu" {
            guard let destination = segue.destination as? DetailMenuVC,
                  
                    let cell = sender as? SuggestionCVCell,
                  
                    let indexPath = self.suggestionCollectionView.indexPath(for: cell),
                  
                    let business = businessess[indexPath.row]
                    
            else { return }
            
            destination.business = business
            destination.delegate = self
        }
    }
  

    //MARK: - Actions
    
    @IBAction func orderNowButtonTapped(_ sender: Any) {
        if tally == 0 {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5) {
                self.driverImage.transform = CGAffineTransform(translationX: 10, y: 1)
            }
            self.driverImage.transform = .identity
            }
    }
    
    
}
