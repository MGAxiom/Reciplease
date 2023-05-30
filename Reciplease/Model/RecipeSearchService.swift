//
//  RecipeSearchService.swift
//  Reciplease
//
//  Created by Maxime Girard on 23/05/2023.
//

import Foundation
import Alamofire

class RecipeSearchService {
    
    static let shared = RecipeSearchService()
    
    func recipeAPI(userInput: String, completionHandler: @escaping (Result<RecipeSearchResult, AFError>) -> Void ) {
        let url = "https://api.edamam.com/search"
        let parameters = ["q": userInput, "app_key": "c3401616aad93b34c82de83bbee1c2c7", "app_id": "4bd1f4d6"]
        
        
        AF.request(url, method: .get, parameters: parameters, encoding:  URLEncoding.default).validate().response { response in
//            print(response.request)
//            print(response.result)

            switch response.result {
            case .success(let data):
//                print(response.result)
                do {
                    let jsondata = try JSONDecoder().decode(RecipeSearchResult.self, from: data!)
//                    handler(jsondata)
                    completionHandler(.success(jsondata))
//                    print(jsondata)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(AF.request.self)
                print(error)
            }
        }
    }
}

//extension Recipe: Recipes {}
