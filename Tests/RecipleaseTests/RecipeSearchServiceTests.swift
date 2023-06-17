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
                let result = item.hits[0].recipe.label
                XCTAssertEqual(result, "Tomato Gravy")
            default:
                XCTFail()
                break
            }

            //XCTAssertNil(recipesSearchService)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipe_WhenNoDataIsPassed_ThenShouldReturnFailedCallback() {
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
//                XCTAssertEqual(error as? AFError, .responseValidationFailed(reason: .unacceptableStatusCode(code: 500)))
            default:
                XCTFail()
                break
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
}
