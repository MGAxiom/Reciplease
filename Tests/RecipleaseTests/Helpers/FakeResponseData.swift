//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Maxime Girard on 13/06/2023.
//

import Foundation

class FakeResponseData {
    
    // MARK: - Response
    
    static let responseOK = HTTPURLResponse(url: URL(string: "https://www.edaman.fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://www.edaman.fr")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    // MARK: - Error
    
    class NetworkError: Error {}
    static let networkError = NetworkError()
    
    // MARK: - Data
    
    static var correctData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        guard let url = bundle.url(forResource: "RecipesSearch", withExtension: "json") else {
            fatalError("Could not find RecipeSearch.json.")
        }
        guard let data = try? Data(contentsOf: url) else { return Data() }
        return data
    }
    
    static let incorrectData = "error".data(using: .utf8)!
}
