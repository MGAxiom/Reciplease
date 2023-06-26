//
//  RecipleaseListViewController.swift
//  Reciplease
//
//  Created by Maxime Girard on 24/05/2023.
//

import UIKit

class RecipleaseListVC: UIViewController {
    
    
    @IBOutlet weak var recipeListTV: UITableView!
    
    var data: [Recipe] = []
//    var recipes: [RecipeDecodable] = []
    var detailsToSend: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeListTV.reloadData()
//        recipes = data.recipes
    }
}
// MARK: - TableView Extension

extension RecipleaseListVC: UITableViewDelegate, UITableViewDataSource {
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
        let recipe = data[indexPath.row]
//        let ingredientLinesString = recipe.decodedIngredientLines.joined(separator: ", ")
        
        cell.configure(imageURL: recipe.imageUrl ?? "" ,title: recipe.title ?? "", subtitle: recipe.ingredients?.capitalized ?? "", calories: recipe.calories ?? "0", time: recipe.time ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailsToSend = data[indexPath.row]
        self.performSegue(withIdentifier: "showRecipeDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecipeDetails" {
            let controller = segue.destination as! RecipleaseDetailVC
            controller.data = detailsToSend
        }
    }
}
