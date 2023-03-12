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
}//End of Class

extension UIView {
    func addVerticalGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [
            #colorLiteral(red: 0.9333333333, green: 0.6117647059, blue: 0.6549019608, alpha: 1).cgColor,
            #colorLiteral(red: 1, green: 0.8666666667, blue: 0.8823529412, alpha: 1).cgColor
        ]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        self.layer.insertSublayer(gradient, at: 0)
    }
}
