//
//  RecipeSessionFake.swift
//  RecipleaseTests
//
//  Created by Maxime Girard on 14/06/2023.
//

import Foundation
import Alamofire
@testable import Reciplease

class RecipeSessionFake {
    
    private let fakeResponse: FakeResponse
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
        static let shared = RecipeSearchService()
        
        func recipeAPI(userInput: String, completionHandler: @escaping (Result<RecipeSearchResult, AFError>) -> Void ) {
            let url = "https://api.edamam.com/search"
            let parameters = ["q": userInput, "app_key": "c3401616aad93b34c82de83bbee1c2c7", "app_id": "4bd1f4d6", "to": "100"]
            
            
            AF.request(url, method: .get, parameters: parameters, encoding:  URLEncoding.default).validate().response { response in
                
                switch response.result {
                case .success(let data):
                    do {
                        let jsondata = try JSONDecoder().decode(RecipeSearchResult.self, from: data!)
                        completionHandler(.success(jsondata))
                    } catch {
                        print(error)
                    }
                case .failure(let error):
                    print(AF.request.self)
                    print(error)
                }
            }
        }
        
        func fetchRecipeImage(imageUrl: String) {
            AF.request(imageUrl, method: .get).responseImage { response in
                
            }
}
