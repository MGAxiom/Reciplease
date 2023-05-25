//
//  RecipleaseMain.swift
//  Reciplease
//
//  Created by Maxime Girard on 24/05/2023.
//

import UIKit

class RecipleaseMainVC: UIViewController {
    
    let data = [""]
    var ingredientsList: [String] = []
    
    @IBOutlet weak var ingredientTextfield: UITextField!
    
    @IBOutlet weak var ingredientListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ingredientListTableView.delegate = self
        self.ingredientListTableView.dataSource = self
        ingredientsList = data
        ingredientsList.removeAll()
        
        RecipeSearchService.shared.recipeAPI(userInput: "chicken")
    }
    
    
    
    @IBAction func addIngredientButton(_ sender: UIButton) {
        let ingredient = ingredientTextfield.text
        ingredientsList.append(ingredient!)
        ingredientTextfield.text?.removeAll()
        self.ingredientListTableView.reloadData()
    }
    
    
    @IBAction func clearIngredientList(_ sender: UIButton) {
        ingredientsList.removeAll()
        ingredientListTableView.reloadData()
    }
    
    
    @IBAction func searchButton(_ sender: UIButton) {
    }
    
    func fetchRecipes() {}
    
}

extension RecipleaseMainVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        cell.textLabel?.font = UIFont(name: "Noteworthy Bold", size: 18)
        cell.textLabel?.textColor = #colorLiteral(red: 0.9546958804, green: 0.9447646141, blue: 0.8713437915, alpha: 1)
        cell.textLabel?.text = " - \(ingredientsList[indexPath.row])"
        return cell
    }
}
