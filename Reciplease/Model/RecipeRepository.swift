//
//  RecipeRepository.swift
//  Reciplease
//
//  Created by Maxime Girard on 06/06/2023.
//

import Foundation
import CoreData

final class RecipeRepository {
    
    // MARK: - Properties
    
    private let coreDataStack: CoreDataStack
    
    // MARK: - Init
    
    init(coreDataStack: CoreDataStack = CoreDataStack.sharedInstance) {
        self.coreDataStack = coreDataStack
    }
    
    // MARK: - Repository
    
    func getRecipe(completion: ([Recipe]) -> Void) {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
//        guard let recipes = try? coreDataStack.viewContext.fetch(request) else {
//            return
//        }
        do {
            let recipes = try coreDataStack.viewContext.fetch(request)
            completion(recipes)
            print("Data has been taken")
//            print(recipes)
        } catch {
            completion([])
            print("Uh oh it failed")
        }
    }
    
    func saveRecipe(title: String, calories: String, time: String, imageUrl: String, ingredients: String, url: String) {
        let recipe = Recipe(context: coreDataStack.viewContext)
        recipe.title = title
        recipe.calories = calories
        recipe.time = time
        recipe.imageUrl = imageUrl
        recipe.ingredients = ingredients
        recipe.url = url
        do {
            try coreDataStack.viewContext.save()
            print("Recipe has been saved.")
        } catch {
            print("Error while trying to save recipe")
        }
    }
}
