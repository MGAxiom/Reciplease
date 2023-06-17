//
//  File.swift
//  RecipleaseTests
//
//  Created by Maxime Girard on 13/06/2023.
//

import Foundation
import Alamofire

struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Data?
    var error: AFError?
}
