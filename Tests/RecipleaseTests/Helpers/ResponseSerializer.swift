//
//  ResponseSerializer.swift
//  Reciplease
//
//  Created by Maxime Girard on 16/06/2023.
//

//import Alamofire
//import Foundation
//
//final class TwoDecodableResponseSerializer<T: Decodable>: ResponseSerializer {
//    typealias SerializedObject = <#type#>
//    
//    
//    lazy var decoder: JSONDecoder = {
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        return decoder
//    }()
//    
//    private let errorCode: StatusCode
//    
//    init(errorCode: StatusCode) {
//        self.errorCode = errorCode
//    }
//    
//    private lazy var successSerializer = DecodableResponseSerializer<T>(decoder: decoder)
//    private lazy var errorSerializer = DecodableResponseSerializer<APIError>(decoder: decoder)
//    
//    public func serialize(request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?) throws -> Result<T, APIError> {
//        
//        guard error == nil else { return .failure(.init(error: error)) }
//        
//        guard let response = response else { return .failure(.noResponseError) }
//        
//        do {
//            if response.statusCode == errorCode {
//                let result = try errorSerializer.serialize(request: request, response: response, data: data, error: nil)
//                return .failure(result)
//            } else {
//                let result = try successSerializer.serialize(request: request, response: response, data: data, error: nil)
//                return .success(result)
//            }
//        } catch(let err) {
//            return .failure(.init(error: err))
//        }
//        
//    }
//    
//}
