//
//  RecipleaseListViewController.swift
//  Reciplease
//
//  Created by Maxime Girard on 24/05/2023.
//

import UIKit

class RecipleaseListVC: UIViewController {
    
    
    @IBOutlet weak var recipeListTV: UITableView!
    
    var data: RecipeSearchResult?
    var recipes: [Recipe] {
        get {
            var res: [Recipe] = []
            guard let recipeData = data else {
                return res
            }
            for hit in recipeData.hits {
                res.append(hit.recipe)
            }
            return res
        }
    }
    var detailsToSend: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(recipes)
        print(recipes.count)
//        print(data?.count)
        
        recipeListTV.reloadData()
        
    }
    
    
}

// MARK: - TableView Extension

extension RecipleaseListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipesListTableViewCell else {
            return UITableViewCell()
        }
        
        
        let recipe = recipes[indexPath.row]
        var ingredientLines: [String] {
            get {
                var foods: [String] = []
                for ingredient in recipe.ingredients! {
                    foods.append(ingredient.food!)
                }
                return foods
            }
        }
        let ingredientLinesString = ingredientLines.joined(separator: ", ")
        
        cell.configure(imageURL: recipe.image!,title: recipe.label!, subtitle: ingredientLinesString.capitalized, likes: "\(recipe.totalTime!)", time: "\(recipe.totalTime!)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Insert precise recipe search API Call
        detailsToSend = recipes[indexPath.row]
        self.performSegue(withIdentifier: "showRecipeDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecipeDetails" {
            let controller = segue.destination as! RecipleaseDetailVC
            controller.data = detailsToSend
        }
    }
}
