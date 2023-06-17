//
//  RecipeSessionFake.swift
//  RecipleaseTests
//
//  Created by Maxime Girard on 14/06/2023.
//

import Foundation
import Alamofire
@testable import Reciplease



class RecipeSessionFake: AFSession {
    
    private let fakeResponse: FakeResponse
    private var acceptableStatusCodes: Range<Int> { 200..<300 }
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
    
    func request(with url: String, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, callback: @escaping (AFDataResponse<Data?>) -> Void) {
        let httpResponse = fakeResponse.response
        let data = fakeResponse.data
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let result:Result<Data?, AFError>
        if fakeResponse.error != nil {
            result = .failure(fakeResponse.error!)
        } else {
            // Simulate Alamofire .validate()
            if acceptableStatusCodes.contains(httpResponse?.statusCode ?? 500) {
                result = .success(fakeResponse.data)
            } else {
                let reason: AFError.ResponseValidationFailureReason = .unacceptableStatusCode(code: httpResponse?.statusCode ?? 500)
                result = .failure(AFError.responseValidationFailed(reason: reason))
            }
            
        }
        
        
        
//        if fakeResponse.error != nil {
//            result = .failure(fakeResponse.error!)
//        } else {
//            do {
//                let json = try JSONResponseSerializer().serialize(request: urlRequest, response: httpResponse, data: data, error: nil)
//                print(json)
//                result = .success(json as? Data)
//            } catch {
//                result = .failure(AFError.responseSerializationFailed(reason: .jsonSerializationFailed(error: error)))
//            }
//        }
            
        // let result = try? JSONResponseSerializer().serialize(request: urlRequest, response: httpResponse, data: data, error: fakeResponse.error)
//        let result:Result<Data?, AFError>
//        do {
//            let decoded = try DecodableResponseSerializer<Data?>().serialize(request: urlRequest, response: httpResponse, data: data, error: nil)
//            result = Result<Data?, AFError>.success(decoded)
//        } catch {
//            result = Result<Data?, AFError>.failure(AFError.explicitlyCancelled)
//        }
        callback(AFDataResponse(request: urlRequest, response: httpResponse, data: data, metrics: .none, serializationDuration: .zero, result: result))
    }
}
