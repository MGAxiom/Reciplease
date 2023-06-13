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
    
    func testFavouriteRecipesAreSaved_WhenAnEntityIsDeleted_ThenShouldBeCorrectlyDeleted() {
        coreDataRepository.saveRecipe(title: "Infused butter", calories: "1000", time: "1h 30min", imageUrl: "https://www.edamam.com/web-img/recipeimage.jpg", ingredients: "butter", url: "http://www.eating.com/recipes/infused-butter-recipe.html", foods: "butter")
        
        coreDataRepository.deleteRecipe(id: "Infused butter")
        XCTAssertTrue(coreDataRepository.checkIfItemExist(id: "Infused butter") == false)
    }
}
