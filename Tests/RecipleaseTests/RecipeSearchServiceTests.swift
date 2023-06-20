//
//  RecipeSearchServiceTests.swift
//  RecipleaseTests
//
//  Created by Maxime Girard on 14/06/2023.
//

import XCTest
@testable import Reciplease
import Alamofire

class RecipeSearchServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }

    func testGetRecipeShouldPostSuccessCallBackIfNoErrorAndCorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData, error: nil)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
        let recipeSearchService = RecipeSearchService(session: recipeSessionFake)

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeSearchService.recipeAPI(userInput: "chicken") { (result) in
            switch result {
            case .success(let item):
                let label = item.recipes[0].label
                let time = item.recipes[0].decodedTime
                let calories = item.recipes[0].roundedCalories
                let ingredients = item.recipes[0].decodedIngredientLines
                XCTAssertEqual(label, "Tomato Gravy")
                XCTAssertEqual(time, "10 min")
                XCTAssertEqual(calories, "1018")
                XCTAssertEqual(ingredients, ["bacon drippings", "all-purpose flour", "tomato paste", "can diced tomatoes", "milk", "heavy cream", "Kosher salt", "black pepper"])
            default:
                XCTFail()
                break
            }

            //XCTAssertNil(recipesSearchService)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipe_WhenInvalidDataIsPassed_ThenShouldReturnFailedCallback() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData, error: nil)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
        let recipeSearchService = RecipeSearchService(session: recipeSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeSearchService.recipeAPI(userInput: "chicken") { (result) in
            switch result {
            case .failure(let error):
                XCTAssertTrue(error is HTTPError)
                XCTAssertEqual(error as? HTTPError, .invalidJson)
            default:
                XCTFail()
                break
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipe_WhenIncorrectResponse_ThenShouldReturnFailedCallback() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctData, error: nil)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
        let recipeSearchService = RecipeSearchService(session: recipeSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeSearchService.recipeAPI(userInput: "chicken") { (result) in
            switch result {
            case .failure(let error):
                XCTAssertTrue(error is AFError)
                switch (error as? AFError) {
                case .responseValidationFailed(reason: .unacceptableStatusCode(code: 500)):
                    break	
                default:
                    XCTFail("Should be .unacceptableStatusCode(code: 500)")
                }
            default:
                XCTFail()
                break
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipe_WhenNoResponse_ShouldReturnEmptyResponse() {
        let fakeResponse = FakeResponse(response: nil, data: FakeResponseData.correctData, error: nil)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
        let recipeSearchService = RecipeSearchService(session: recipeSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeSearchService.recipeAPI(userInput: "chicken") { (result) in
            switch result {
            case .failure(let error):
                XCTAssertTrue(error is AFError)
                switch (error as? AFError) {
                case .responseSerializationFailed(reason: .invalidEmptyResponse(type: "Empty")):
                    break
                default:
                    XCTFail("Should be .responseSerializatioFailed")
                }
            default:
                XCTFail()
                break
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
}
