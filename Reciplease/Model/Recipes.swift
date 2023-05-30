//
//  Recipe.swift
//  Reciplease
//
//  Created by Maxime Girard on 29/05/2023.
//

import Foundation

protocol Recipes {
    
    var title: String { get }
    var description: String { get }
    var likes: String { get }
    var time: String { get }
}
