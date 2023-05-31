//
//  RecipeResult.swift
//  Reciplease
//
//  Created by Maxime Girard on 24/05/2023.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let recipeSearchResult = try? JSONDecoder().decode(RecipeSearchResult.self, from: jsonData)

import Foundation

// MARK: - RecipeSearchResult
struct RecipeSearchResult: Codable {
    let q: String
    let hits: [Hit]
    let count: Int
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe
}

// MARK: - Recipe
struct Recipe: Codable {
    let uri: String?
    let label: String?
    let image: String?
    let source: String?
    let url: String?
    let shareAs: String?
    let yield: Int?
    let dietLabels, healthLabels, cautions, ingredientLines: [String]?
    let ingredients: [Ingredient]?
    let calories, totalWeight, totalTime: Double?
//    let mealType: [MealType]?
//    let dishType: [String]?
//    let totalNutrients, totalDaily: [String: Total]?
//    let digest: [Digest]?
}

enum CuisineType: String, Codable {
    case american = "american"
    case kosher = "kosher"
    case southAmerican = "south american"
}

// MARK: - Digest
struct Digest: Codable {
    let label, tag: String?
    let schemaOrgTag: SchemaOrgTag?
    let total: Double?
    let hasRDI: Bool?
    let daily: Double?
    let unit: Unit?
    let sub: [Digest]?
}

enum SchemaOrgTag: String, Codable {
    case carbohydrateContent = "carbohydrateContent"
    case cholesterolContent = "cholesterolContent"
    case fatContent = "fatContent"
    case fiberContent = "fiberContent"
    case proteinContent = "proteinContent"
    case saturatedFatContent = "saturatedFatContent"
    case sodiumContent = "sodiumContent"
    case sugarContent = "sugarContent"
    case transFatContent = "transFatContent"
}

enum Unit: String, Codable {
    case empty = "%"
    case g = "g"
    case kcal = "kcal"
    case mg = "mg"
    case µg = "µg"
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let text: String?
    let quantity: Double?
    let measure: String?
    let food: String?
    let weight: Double?
    let foodCategory, foodID: String?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case text, quantity, measure, food, weight, foodCategory
        case foodID = "foodId"
        case image
    }
}

enum MealType: String, Codable {
    case breakfast = "breakfast"
    case lunchDinner = "lunch/dinner"
    case snack = "snack"
}

// MARK: - Total
struct Total: Codable {
    let label: String?
    let quantity: Double?
    let unit: Unit?
}
