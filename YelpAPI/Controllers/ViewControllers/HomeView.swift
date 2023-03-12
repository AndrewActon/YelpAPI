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
    @IBOutlet weak var orderView: UIView!
    
    
    
    
    
    //MARK: - Lifecylce Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        suggestionCollectionView.delegate = self
        suggestionCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
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
        //Location Stack
        locationImage.image = UIImage(systemName: "location")
        locationImage.tintColor = .orange
        locationLabel.text = "Layton, UT"
        
        //Order View
        orderView.layer.cornerRadius = 15
        orderView.addVerticalGradientLayer()
        orderNowButton.layer.cornerRadius = 15
        if tally == 0 {
            orderNowButton.setTitle("No Orders", for: .normal)
        } else {
            orderNowButton.setTitle("Order Now \(tally)", for: .normal)
        }
        
        popularLabel.text = "Popular"
        foodCategoriesLabel.text = "Food Categories"
    }
    
    //animateOffScreen animation function
        func animateOffScreen(imageView: UIImageView) {
            let originalCenter = imageView.center
            UIView.animateKeyframes(withDuration: 1.5, delay: 0.0, animations: {

                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25, animations: {
                    imageView.center.x -= 80.0
                    imageView.center.y += 10.0
                })

                UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.4) {
                    imageView.transform = CGAffineTransform(rotationAngle: -.pi / 80)
                }

                UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                    imageView.center.x -= 100.0
                    imageView.center.y += 50.0
                    imageView.alpha = 0.0
                }

                UIView.addKeyframe(withRelativeStartTime: 0.51, relativeDuration: 0.01) {
                    imageView.transform = .identity
                    imageView.center = CGPoint(x:  900.0, y: 100.0)
                }

                UIView.addKeyframe(withRelativeStartTime: 0.55, relativeDuration: 0.45) {
                    imageView.center = originalCenter
                    imageView.alpha = 1.0
                }

            }, completion: { (_) in
                self.tally = 0
                self.orderNowButton.setTitle("No Orders", for: .normal)
            })
        }
    
    //MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoriesCollectionView {
            return CategoryOptions.categories.count
        }
            return businessess.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoriesCollectionView {
            guard let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "categoriesCell", for: indexPath) as? CategoryCollectionViewCell
            else { return UICollectionViewCell() }
            
            let category = CategoryOptions.categories[indexPath.row]
            cell.updateViews(category: category)
            
            return cell
                    
        }
        
            guard let cell = suggestionCollectionView.dequeueReusableCell(withReuseIdentifier: "suggestionCell", for: indexPath) as? SuggestionCVCell,
                  
                    let bussiness = businessess[indexPath.row]
                    
            else { return UICollectionViewCell() }
            
            
            cell.updateViews(business: bussiness)
            cell.suggestionImage.load(url: bussiness.imageURL)
            
            return cell

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
        else if segue.identifier == "toCategoryTableView" {
            guard let destination = segue.destination as? CategoryTableViewController,
                  let cell = sender as? CategoryCollectionViewCell,
                  let indexPath = self.categoriesCollectionView.indexPath(for: cell)
            else { return }
                    
            let selectedCategory = CategoryOptions.categories[indexPath.row]
            destination.category = selectedCategory
        }
    }
  

    //MARK: - Actions
    
    @IBAction func orderNowButtonTapped(_ sender: Any) {
        if tally == 0 {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5) {
                self.driverImage.transform = CGAffineTransform(translationX: 10, y: 1)
            }
            self.driverImage.transform = .identity
        } else if tally > 0 {
            animateOffScreen(imageView: driverImage)
        }
    }
    
    
}
