//
//  CategoryTableViewController.swift
//  YelpAPI
//
//  Created by Andrew Acton on 3/8/23.
//

import UIKit

class CategoryTableViewController: UITableViewController {

    //MARK: - Properties
    var category: Category?
    var business: [Business] = []
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBusinessess()
    }

    //MARK: - Helper Methods
    func fetchBusinessess() {
        guard let category = category else { return }
        BusinessController.shared.fetchBusiness(searchTerm: category.title) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let business):
                    self.business = business
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
                }
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return business.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as? CategoryDetailTableViewCell,
              let category = category
        else { return UITableViewCell() }
        
        let business = business[indexPath.row]
        
        cell.categoryDetailTitleLabel.text = business.name
        cell.categoryDetailRatingLabel.text = "\(business.rating)"
        cell.categoryDetailImage.image = UIImage(named: category.imageName)
        print(category.title)
        
        return cell
    }

}
