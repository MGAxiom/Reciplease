//
//  RecipeSearchService.swift
//  Reciplease
//
//  Created by Maxime Girard on 23/05/2023.
//

import Foundation
import Alamofire

class RecipeSearchService {
    
    func recipeAPI(userInput: String) {
        let parameters = ["q": userInput, "app_key": "c3401616aad93b34c82de83bbee1c2c7", "app_id": "4bd1f4d6"]
        
        AF.request("https://api.edamam.com/search", method: .get, parameters: parameters).response { response in
            debugPrint("\(response)")
        }
    }
}
