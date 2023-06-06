//
//  RecipleaseDetailVC.swift
//  Reciplease
//
//  Created by Maxime Girard on 24/05/2023.
//

import UIKit
import AlamofireImage

class RecipleaseDetailVC: UIViewController {
    
    var data: RecipeDecodable?
    private let repository = RecipeRepository()
    
    @IBOutlet weak var recipePlaceholder: UIImageView!
    @IBOutlet weak var titleRecipe: UILabel!
    
    @IBOutlet weak var ingredientsOfRecipeTV: UITableView!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transferDetails()
    }
    
    @IBAction func getInstructionsButton(_ sender: UIButton) {
        if let url = URL(string: data?.url ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func favoriteButton(_ sender: Any) {
        addRecipe()
//        UIButton.image = UIImage(systemName: "star.filled")
//        let ingredientLinesString = data?.ingredientLines!.joined(separator: ", ")
//        saveRecipe(title: (data?.label)!, calories: data!.roundedCalories, time: data!.decodedTime, imageUrl: (data?.image)!, ingredients: ingredientLinesString!, url: (data?.url)!)
    }
    
    func transferDetails() {
        let url = URL(string: (data?.image)!)!
        
        recipePlaceholder.af.setImage(withURL: url)
        let gradient = CAGradientLayer()

        gradient.frame = recipePlaceholder.bounds
        gradient.colors = [
            UIColor(white: 0, alpha: 0.01).cgColor,
            UIColor.black.cgColor,
        ]
        gradient.locations = [0.0, 1.3]
        recipePlaceholder.layer.insertSublayer(gradient, at: 1)
        
        
        titleRecipe.text = data?.label
        caloriesLabel.text = data?.roundedCalories
        timeLabel.text = data?.decodedTime
    }
    
    private func addRecipe() {
        let ingredientLinesString = (data?.ingredientLines!.joined(separator: ", "))!
        repository.saveRecipe(title: (data?.label)!, calories: data!.roundedCalories, time: data!.decodedTime, imageUrl: (data?.image)!, ingredients: ingredientLinesString, url: (data?.url)!)
    }
    
    
//    private func saveRecipe(title: String, calories: String, time: String, imageUrl: String, ingredients: String, url: String) {
//        let recipe = Recipe(context: CoreDataStack.sharedInstance.viewContext)
//        recipe.title = title
//        recipe.calories = calories
//        recipe.time = time
//        recipe.imageUrl = imageUrl
//        recipe.ingredients = ingredients
//        recipe.url = url
//        do {
//            try CoreDataStack.sharedInstance.viewContext.save()
//            print("Recipe has been saved.")
//        } catch {
//            print("Error while trying to save recipe")
//        }
//    }
}

extension RecipleaseDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (data?.ingredientLines!.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeIngredientsCell", for: indexPath)
        cell.textLabel?.numberOfLines = 5
        cell.textLabel?.text = " - \(data?.ingredientLines?[indexPath.row].capitalized ?? "")"
        cell.textLabel?.font = UIFont(name: "Noteworthy Bold", size: 15)
        cell.textLabel?.textColor = #colorLiteral(red: 0.9546958804, green: 0.9447646141, blue: 0.8713437915, alpha: 1)
        return cell
    }
    
    
}
