//
//  RecipesListTableViewCell.swift
//  Reciplease
//
//  Created by Maxime Girard on 29/05/2023.
//

import UIKit

class RecipesListTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImageVIew: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure( title: String, subtitle: String, likes: String, time: String) {
    
//        cellImageVIew.image = UIImage(named: icon)
        
        titleLabel.text = title
        
        descriptionLabel.text = subtitle
        
        likesLabel.text = likes
        
        timeLabel.text = time
        
    }
}
