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
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(imageURL: String, title: String, subtitle: String, likes: String, time: String) {
    
//        cellImageView.image = UIImage(named: icon)
        let url = URL(string: imageURL)!
//        let filter = AspectScaledToFitSizeFilter(size: cellImageView.frame.size)
        cellImageView.af.setImage(withURL: url)
        
        titleLabel.text = title
        
        descriptionLabel.text = subtitle
        
        likesLabel.text = likes
        
        timeLabel.text = time
        
    }
}
