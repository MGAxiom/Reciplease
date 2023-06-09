//
//  FavouriteListVC.swift
//  Reciplease
//
//  Created by Maxime Girard on 24/05/2023.
//

import UIKit
import CoreData

class FavouriteListVC: UIViewController {
    
    var favouriteData = [Recipe]()
    let repository = RecipeRepository()
    var favouriteDetailsToSend: Recipe?
    
    @IBOutlet weak var favouriteListTV: UITableView!
    @IBOutlet weak var favouriteDescription: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRecipes()
        favouriteListTV.reloadData()
        if favouriteData.count == 0 {
            favouriteDescription.isHidden = false
            favouriteListTV.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRecipes()
    }
    
    private func fetchRecipes() {
        repository.getAllRecipes(completion: { [weak self] data in
            self?.favouriteData = data
            self?.favouriteListTV.reloadData()
            print(self!.favouriteData)
        })
    }
}

extension FavouriteListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteRecipeCell", for: indexPath) as? FavouriteListTableViewCell else {
            return UITableViewCell()
        }
        let recipe = favouriteData[indexPath.row]
        cell.configure(imageURL: recipe.imageUrl!,title: recipe.title!, subtitle: recipe.ingredients?.capitalized ?? "", calories: recipe.calories!, time: recipe.time!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        favouriteDetailsToSend = repository.getRecipeDetails(id: favouriteData[indexPath.row].title!)
        self.performSegue(withIdentifier: "showFavouritesDetails", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFavouritesDetails" {
            let controller = segue.destination as! FavouriteDetailVC
            controller.data = favouriteDetailsToSend
        }
    }
}
