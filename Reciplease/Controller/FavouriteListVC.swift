//
//  FavouriteListVC.swift
//  Reciplease
//
//  Created by Maxime Girard on 24/05/2023.
//

import UIKit
import CoreData

class FavouriteListVC: UIViewController {
    
    var data: [Recipe] = [Recipe]()
    
    @IBOutlet weak var favouriteListTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        guard let recipe = try? CoreDataStack.sharedInstance.viewContext.fetch(request) else { return }
    }
}

extension FavouriteListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipesListTableViewCell else {
            return UITableViewCell()
        }
        
        
        let recipe = recipes[indexPath.row]
        
        let ingredientLinesString = recipe.decodedIngredientLines.joined(separator: ", ")
        
        cell.configure(imageURL: recipe.image! ,title: recipe.label!, subtitle: ingredientLinesString.capitalized, calories: recipe.roundedCalories, time: recipe.decodedTime)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailsToSend = recipes[indexPath.row]
        self.performSegue(withIdentifier: "showRecipeDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecipeDetails" {
            let controller = segue.destination as! RecipleaseDetailVC
            controller.data = detailsToSend
        }
        }
