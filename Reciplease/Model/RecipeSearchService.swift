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
    
    func recipeAPI(userInput: String) {
        let url = "https://api.edamam.com/search"
        let parameters = ["q": userInput, "app_key": "c3401616aad93b34c82de83bbee1c2c7", "app_id": "4bd1f4d6"]
        
        AF.request(url, method: .get, parameters: parameters, encoding:  URLEncoding.default).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let jsondata = try JSONDecoder().decode(RecipeSearchResult.self, from: data!)
                    print(jsondata)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(AF.request.self)
                print(error.localizedDescription)
            }
        }
    }
}
