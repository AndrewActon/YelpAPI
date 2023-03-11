//
//  CategoryCollectionViewCell.swift
//  YelpAPI
//
//  Created by Andrew Acton on 3/8/23.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    var category: Category?
    
    
    //MARK: - Outlets
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    func updateViews(category: Category) {
        categoryLabel.text = category.title
        categoryImage.image = UIImage(named: category.imageName)
    }
}
