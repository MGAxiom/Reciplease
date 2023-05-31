//
//  RecipleaseDetailVC.swift
//  Reciplease
//
//  Created by Maxime Girard on 24/05/2023.
//

import UIKit
import AlamofireImage

class RecipleaseDetailVC: UIViewController {
    
    var data: Recipe?
    
    
    @IBOutlet weak var recipePlaceholder: UIImageView!
    @IBOutlet weak var titleRecipe: UILabel!
    
    @IBOutlet weak var ingredientsOfRecipeTV: UITableView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: (data?.image)!)!
        recipePlaceholder.af.setImage(withURL: url)
        titleRecipe.text = data?.label
        likeLabel.text = "\(data?.totalTime)"
        timeLabel.text = "\(data?.totalTime)"
        
    }
    
    
}

extension RecipleaseDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (data?.ingredients!.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeIngredientsCell", for: indexPath)
        cell.textLabel?.text = " - \(data?.ingredients!)"
        return cell
        
    }
    
    
}
