//
//  Extensions.swift
//  YelpAPI
//
//  Created by Andrew Acton on 3/2/23.
//

import UIKit

extension UIImageView {
    func load(url: String) {
        DispatchQueue.global().async {
            [weak self] in
            guard let urlString = URL(string: url) else { return }
            if let data = try? Data(contentsOf: urlString) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

