//
//  RecipeSearchService.swift
//  Reciplease
//
//  Created by Maxime Girard on 23/05/2023.
//

import Foundation
import Alamofire
import AlamofireImage

class RecipeSearchService {
    
    //MARK: - Properties
    
    private let session: AFSession
    static let shared = RecipeSearchService()
    //MARK: - Initializer
    
    init(session: AFSession = SearchSession()) {
        self.session = session
    }
    
    func recipeAPI(userInput: String, callback: @escaping (Result<RecipeSearchResult, Error>) -> Void ) {
        let url = "https://api.edamam.com/search"
        let parameters = ["q": userInput, "app_key": "c3401616aad93b34c82de83bbee1c2c7", "app_id": "4bd1f4d6", "to": "100"]
        
                
        session.request(with: url, method: .get, parameters: parameters, encoding: URLEncoding.default) { response in
            
            switch response.result {
            case .success(let data):
                do {
                    let jsondata = try JSONDecoder().decode(RecipeSearchResult.self, from: data!)
                    callback(.success(jsondata))
                } catch {
                    print(error)
                    callback(.failure(HTTPError.invalidJson))
                }
            case .failure(let error):
                print(AF.request.self)
                print(error)
                callback(.failure(error))
            }
        }
    }
    
    func fetchRecipeImage(imageUrl: String) {
        AF.request(imageUrl, method: .get).responseImage { response in
            
        }
    }
}
