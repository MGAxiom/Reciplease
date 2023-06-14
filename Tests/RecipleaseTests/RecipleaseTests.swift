//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Maxime Girard on 19/05/2023.
//

import XCTest
import CoreData
@testable import Reciplease

final class RecipleaseTests: XCTestCase {
    
    // MARK: - Properties
    
    var coreDataStack: TestCoreDataStack!
    var coreDataRepository: RecipeRepository!
    var favouriteDataTest: [Recipe] = []
    
    // MARK: - Test Life Cycle
    
    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack(modelName: "Reciplease")
        coreDataRepository = RecipeRepository(coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()	
        coreDataRepository = nil
        coreDataStack = nil
        favouriteDataTest.removeAll()
    }
    
    
    // MARK: - Tests
    
    func testAddRecipeMethods_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
        coreDataRepository.saveRecipe(title: "Infused butter", calories: "1000", time: "1h 30min", imageUrl: "https://www.edamam.com/web-img/recipeimage.jpg", ingredients: "butter", url: "http://www.eating.com/recipes/infused-butter-recipe.html", foods: "butter")
        XCTAssertTrue(coreDataRepository.checkIfItemExist(id: "Infused butter") == true)
        XCTAssertTrue(coreDataRepository.getRecipeDetails(id: "Infused butter")?.title == "Infused butter")
        XCTAssertTrue(coreDataRepository.getRecipeDetails(id: "Infused butter")?.calories == "1000")
        XCTAssertTrue(coreDataRepository.getRecipeDetails(id: "Infused butter")?.foods == "butter")
        XCTAssertTrue(coreDataRepository.getRecipeDetails(id: "Infused butter")?.imageUrl == "https://www.edamam.com/web-img/recipeimage.jpg")
        XCTAssertTrue(coreDataRepository.getRecipeDetails(id: "Infused butter")?.ingredients == "butter")
        XCTAssertTrue(coreDataRepository.getRecipeDetails(id: "Infused butter")?.time == "1h 30min")
        XCTAssertTrue(coreDataRepository.getRecipeDetails(id: "Infused butter")?.url == "http://www.eating.com/recipes/infused-butter-recipe.html")
    }
    
//    func testAddIncorrectRecipeMethods_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
//        coreDataRepository.saveRecipe(title: "Infused butter", calories: "1004", time: "1h 30min", imageUrl: "https://www.edamam.com/web-img/recipeimage.jpg", ingredients: "butter", url: "http://www.eating.com/recipes/infused-butter-recipe.html", foods: "butter")
//        XCTAssertTrue(coreDataRepository.checkIfItemExist(id: "Infused butter") == false)
//        XCTAssertThrowsError(print("Error while trying to save recipe"))
//    }
    
    func testFavouriteRecipesAreSaved_WhenAnEntityIsDeleted_ThenShouldBeCorrectlyDeleted() {
        coreDataRepository.saveRecipe(title: "Infused butter", calories: "1000", time: "1h 30min", imageUrl: "https://www.edamam.com/web-img/recipeimage.jpg", ingredients: "butter", url: "http://www.eating.com/recipes/infused-butter-recipe.html", foods: "butter")
        
        coreDataRepository.deleteRecipe(id: "Infused butter")
        XCTAssertTrue(coreDataRepository.checkIfItemExist(id: "Infused butter") == false)
    }
    
    func testFavouriteRecipesAreSaved_WhenTryingToFetchAllRecipes_ThenShouldGetAllRecipesSaved() {
        coreDataRepository.saveRecipe(title: "Infused butter", calories: "1000", time: "1h 30min", imageUrl: "https://www.edamam.com/web-img/recipeimage.jpg", ingredients: "butter", url: "http://www.eating.com/recipes/infused-butter-recipe.html", foods: "butter")
        
        coreDataRepository.saveRecipe(title: "Marinated chicken", calories: "2345", time: "4h", imageUrl: "https://www.edamam.com/web-img/recipechickenimage.jpg", ingredients: "butter, chicken", url: "http://www.eating.com/recipes/marinated-chicken-recipe.html", foods: "butter, chicken")
        
        
        coreDataRepository.getAllRecipes(completion: { [weak self] data in
            self?.favouriteDataTest = data})
        
        XCTAssertNotEqual(favouriteDataTest.count, nil)
    }
}
