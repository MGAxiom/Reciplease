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
    var recipes: [RecipeDecodable] {
        get {
            var res: [RecipeDecodable] = []
            guard let recipeData = data else {
                return res
            }
            for hit in recipeData.hits {
                res.append(hit.recipe)
            }
            return res
        }
    }
    var detailsToSend: RecipeDecodable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(recipes)
//        print(recipes.count)
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
}
