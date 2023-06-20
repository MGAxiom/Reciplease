//
//  AFSession.swift
//  Reciplease
//
//  Created by Maxime Girard on 15/06/2023.
//

import Foundation
import Alamofire

protocol AFSession {
    func request(with url: String, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, callback: @escaping (AFDataResponse<Data?>) -> Void)
}

final class SearchSession: AFSession {
    
    var parameters: [String] = [""]
    
    func request(with url: String, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, callback: @escaping (AFDataResponse<Data?>) -> Void) {
        AF.request(url, method: .get, parameters: parameters, encoding:  URLEncoding.default).validate().response { response in
            callback(response)
        }
    }
}
