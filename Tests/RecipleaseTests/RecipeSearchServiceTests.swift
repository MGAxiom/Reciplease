//
//  RecipeSearchServiceTests.swift
//  RecipleaseTests
//
//  Created by Maxime Girard on 14/06/2023.
//

import XCTest
@testable import Reciplease

//func testGetRecipesShouldPostFailedCallback() {
//    let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)
//    let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
//    let recipeService = RecipeService(recipeSession: recipeSessionFake)
//    
//    let expectation = XCTestExpectation(description: "Wait for queue change.")
//    recipeService.getRecipes(ingredientsList: ingredientsList) { (success, recipesSearch) in
//        XCTAssertFalse(success)
//        XCTAssertNil(recipesSearch)
//        expectation.fulfill()
//    }
//    
//    wait(for: [expectation], timeout: 0.01)
//    }
