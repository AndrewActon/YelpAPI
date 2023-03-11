//
//  CategoryDetailTableViewCell.swift
//  YelpAPI
//
//  Created by Andrew Acton on 3/9/23.
//

import UIKit

class CategoryDetailTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var categoryDetailRatingLabel: UILabel!
    @IBOutlet weak var categoryDetailImage: UIImageView!
    @IBOutlet weak var categoryDetailTitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
