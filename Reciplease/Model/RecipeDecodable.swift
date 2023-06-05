//
//  RecipeResult.swift
//  Reciplease
//
//  Created by Maxime Girard on 24/05/2023.
//

import Foundation

// MARK: - RecipeSearchResult
struct RecipeSearchResult: Codable {
    let q: String
    let hits: [Hit]
    let count: Int
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: RecipeDecodable
}

// MARK: - Recipe
struct RecipeDecodable: Codable {
    let uri: String?
    let label: String?
    let image: String?
    let source: String?
    let url: String?
    let shareAs: String?
    let yield: Double?
    let dietLabels, healthLabels, cautions, ingredientLines: [String]?
    var decodedIngredientLines: [String] {
        get {
            var foods: [String] = []
            guard let data = ingredients else {
                return foods
            }
            for ingredient in data {
                guard let food = ingredient.food else {
                    continue
                }
                foods.append(food)
            }
            return foods
        }
    }
    let ingredients: [Ingredient]?
    let calories, totalWeight, totalTime: Double?
    var decodedTime: String {
        get {
            let interval = (totalTime ?? 0) * 60
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.hour, .minute]
            formatter.unitsStyle = .brief
            
            let formattedString = formatter.string(from: TimeInterval(interval))!
            return formattedString
            }
        }
        
    var roundedCalories: String {
            var cal = calories
            cal?.round()
            return String(format: "%.0f", cal ?? 0.0)
    }
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
