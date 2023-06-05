//
//  RecipesListTableViewCell.swift
//  Reciplease
//
//  Created by Maxime Girard on 29/05/2023.
//

import UIKit
import AlamofireImage

class RecipesListTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(imageURL: String, title: String, subtitle: String, calories: String, time: String) {
    

        let url = URL(string: imageURL)!
        cellImageView.af.setImage(withURL: url)
        let gradient = CAGradientLayer()
        gradient.frame = cellImageView.frame
        gradient.colors = [
            UIColor(white: 0, alpha: 0.01).cgColor,
            UIColor.black.cgColor,
        ]
//        let resizedImage =  cellImageView.image?.resizeUI(size: CGSize(width: 393, height: 155))
        cellImageView.layer.insertSublayer(gradient, at: 0)
        
        titleLabel.text = title
        
        descriptionLabel.text = subtitle
        
        caloriesLabel.text = calories
        
        timeLabel.text = time
        
    }
    

}

//extension UIImage {
//    func resizeUI(size:CGSize) -> UIImage? {
//        UIGraphicsBeginImageContextWithOptions(size, true, self.scale)
//        self.draw(in: CGRect(origin: CGPointZero, size: size))
//
//        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return resizedImage
//    }
//}
