//
//  FavouriteDetailVC.swift
//  Reciplease
//
//  Created by Maxime Girard on 24/05/2023.
//

import UIKit
import AlamofireImage

class FavouriteDetailVC: UIViewController {
    
    var data: Recipe?
    private let repository = RecipeRepository()
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ingredientsForRecipeTV: UITableView!
    @IBOutlet weak var favoriteButtonItem: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transferDetails()
        
    }
    
    @IBAction func getInstructionsButton(_ sender: UIButton) {
        if let url = URL(string: data?.url ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func favouriteButton(_ sender: UIButton) {
        if repository.checkIfItemExist(id: recipeTitle.text!) == true {
        presentAlertVC(with: "This recipe is already in your favourites. Do you want to remove it?", recipeName: recipeTitle.text!)
        checkNavIcon()
    } else {
//        CoreDataStack.sharedInstance.viewContext.undo()
        checkNavIcon()
    }
    }
    
    func transferDetails() {
        let url = URL(string: data?.imageUrl ?? "")!
        
        recipeImage.af.setImage(withURL: url)
        let gradient = CAGradientLayer()
        
        gradient.frame = recipeImage.bounds
        gradient.colors = [
            UIColor(white: 0, alpha: 0.01).cgColor,
            UIColor.black.cgColor,
        ]
        gradient.locations = [0.0, 1.3]
        recipeImage.layer.insertSublayer(gradient, at: 1)
        
        
        recipeTitle.text = data?.title
        caloriesLabel.text = data?.calories
        timeLabel.text = data?.time
    }
    
    private func addRecipe() {
        repository.saveRecipe(title: (data?.title)!, calories: data!.calories!, time: (data?.time)!, imageUrl: (data?.imageUrl)!, ingredients: (data?.ingredients)!, url: (data?.url)!, foods: (data?.foods)!)
    }
    
    func checkNavIcon() {
        if repository.checkIfItemExist(id: recipeTitle.text!) == true {
            favoriteButtonItem.image = Image(systemName: "star.fill")
        } else {
            favoriteButtonItem.image = Image(systemName: "star")
        }
    }
}


extension FavouriteDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let string = data?.ingredients ?? ""
        let ingredientArray = string.components(separatedBy: ",")
        return ingredientArray.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeIngredientsCell", for: indexPath)
        let string = data?.ingredients ?? ""
        let ingredientArray = string.components(separatedBy: ",")
        cell.textLabel?.numberOfLines = 5
        cell.textLabel?.text = " - \(ingredientArray[indexPath.row].capitalized )"
        cell.textLabel?.font = UIFont(name: "Noteworthy Bold", size: 15)
        cell.textLabel?.textColor = #colorLiteral(red: 0.9546958804, green: 0.9447646141, blue: 0.8713437915, alpha: 1)
        return cell
    }
}

extension FavouriteDetailVC {

    func presentAlertVC(with message: String, recipeName: String, okCompletion: @escaping (() -> ()) = {}, cancelCompletion: @escaping (() -> ()) = {}, presentCompletion: @escaping (() -> ()) = {}) {
        let alertController = UIAlertController(title: "Ooops !", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
            RecipeRepository().deleteRecipe(id: recipeName)
            self.checkNavIcon()
            okCompletion()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (cancel: UIAlertAction) in
            cancelCompletion()
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true) {
                presentCompletion()
            }
        }
    }
}
