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
    let database = Recipe?.self
    
    @IBOutlet weak var recipePlaceholder: UIImageView!
    @IBOutlet weak var titleRecipe: UILabel!
    
    @IBOutlet weak var ingredientsOfRecipeTV: UITableView!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transferDetails()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkNavIcon()
    }
    
    @IBAction func getInstructionsButton(_ sender: UIButton) {
        if let url = URL(string: data?.url ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func favoriteButton(_ sender: Any) {
        if repository.checkIfItemExist(id: titleRecipe.text!) == true {
            presentAlertVC(with: "This recipe is already in your favourites. Do you want to remove it?", recipeName: titleRecipe.text!)
            checkNavIcon()
        } else {
            addRecipe()
            checkNavIcon()
        }
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
        let foodLineString = (data?.decodedIngredientLines.joined(separator: ", "))!
        repository.saveRecipe(title: (data?.label)!, calories: data!.roundedCalories, time: data!.decodedTime, imageUrl: (data?.image)!, ingredients: ingredientLinesString, url: (data?.url)!, foods: foodLineString)
    }
    
    func checkNavIcon() {
        if repository.checkIfItemExist(id: titleRecipe.text!) == true {
            favoriteButton.image = Image(systemName: "star.fill")
        } else {
            favoriteButton.image = Image(systemName: "star")
        }
    }
    
    func presentAlertVC(with messsage: String, recipeName: String) {
        let alert = UIAlertController(title: "Oops !", message: messsage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .default))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [self] action in
            RecipeRepository().deleteRecipe(id: recipeName)
            checkNavIcon()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
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
