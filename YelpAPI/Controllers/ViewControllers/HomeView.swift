//
//  HomeView.swift
//  YelpAPI
//
//  Created by Andrew Acton on 2/27/23.
//

import UIKit

class HomeView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //MARK: - Properties
    var businessess: [Business?] = [] {
        didSet {
            DispatchQueue.main.async {
                self.suggestionCollectionView.reloadData()
                print(self.businessess.count)
            }
        }
    }

    //MARK: - Outlets
    @IBOutlet weak var popularLabel: UILabel!
//    @IBOutlet weak var orderNowImage: UIImageView!
    @IBOutlet weak var orderNowLabel: UILabel!
    @IBOutlet weak var suggestionCollectionView: UICollectionView!
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    
    //MARK: - Lifecylce Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        suggestionCollectionView.delegate = self
        suggestionCollectionView.dataSource = self
        popularLabel.text = "Popular"
        locationLabel.text = "Layton, UT"
        locationImage.image = UIImage(systemName: "location")
        fetchPopular()
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
    
    //MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return businessess.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = suggestionCollectionView.dequeueReusableCell(withReuseIdentifier: "suggestionCell", for: indexPath) as? SuggestionCVCell,
        
                let bussiness = businessess[indexPath.row]
                
                else { return UICollectionViewCell() }
        
        
        cell.updateViews(business: bussiness)
        cell.suggestionImage.load(url: bussiness.imageURL)
        
        return cell
    }
    
     
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailMenu" {
            guard let destination = segue.destination as? DetailMenuVC,
                  
                    let cell = sender as? SuggestionCVCell,
                  
                    let indexPath = self.suggestionCollectionView.indexPath(for: cell),
                  
                    let business = businessess[indexPath.row]
                    
            else { return }
            
            destination.business = business
        }
    }
  

    //MARK: - Actions
    
    @IBAction func orderNowButtonTapped(_ sender: Any) {
        
    }
    
    
}
