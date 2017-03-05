//
//  NutritionInfo.swift
//
//  Created by Wilson Ding on 3/4/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class NutritionInfo {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let sodium = "Sodium"
    static let dietaryFiber = "DietaryFiber"
    static let totalCalories = "TotalCalories"
    static let protein = "Protein"
    static let polyFat = "PolyFat"
    static let totalFat = "TotalFat"
    static let potassiumPct = "PotassiumPct"
    static let sugar = "Sugar"
    static let transFat = "TransFat"
    static let potassium = "Potassium"
    static let caloriesFromFat = "CaloriesFromFat"
    static let proteinPct = "ProteinPct"
    static let satFatPct = "SatFatPct"
    static let monoFat = "MonoFat"
    static let totalCarbs = "TotalCarbs"
    static let cholesterol = "Cholesterol"
    static let cholesterolPct = "CholesterolPct"
    static let satFat = "SatFat"
    static let singularYieldUnit = "SingularYieldUnit"
    static let totalFatPct = "TotalFatPct"
    static let totalCarbsPct = "TotalCarbsPct"
    static let dietaryFiberPct = "DietaryFiberPct"
    static let sodiumPct = "SodiumPct"
  }

  // MARK: Properties
  public var sodium: Float?
  public var dietaryFiber: Float?
  public var totalCalories: Int?
  public var protein: Float?
  public var polyFat: Float?
  public var totalFat: Float?
  public var potassiumPct: Float?
  public var sugar: Float?
  public var transFat: Float?
  public var potassium: Float?
  public var caloriesFromFat: Int?
  public var proteinPct: Float?
  public var satFatPct: Float?
  public var monoFat: Float?
  public var totalCarbs: Float?
  public var cholesterol: Float?
  public var cholesterolPct: Float?
  public var satFat: Float?
  public var singularYieldUnit: String?
  public var totalFatPct: Float?
  public var totalCarbsPct: Float?
  public var dietaryFiberPct: Float?
  public var sodiumPct: Float?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    sodium = json[SerializationKeys.sodium].float
    dietaryFiber = json[SerializationKeys.dietaryFiber].float
    totalCalories = json[SerializationKeys.totalCalories].int
    protein = json[SerializationKeys.protein].float
    polyFat = json[SerializationKeys.polyFat].float
    totalFat = json[SerializationKeys.totalFat].float
    potassiumPct = json[SerializationKeys.potassiumPct].float
    sugar = json[SerializationKeys.sugar].float
    transFat = json[SerializationKeys.transFat].float
    potassium = json[SerializationKeys.potassium].float
    caloriesFromFat = json[SerializationKeys.caloriesFromFat].int
    proteinPct = json[SerializationKeys.proteinPct].float
    satFatPct = json[SerializationKeys.satFatPct].float
    monoFat = json[SerializationKeys.monoFat].float
    totalCarbs = json[SerializationKeys.totalCarbs].float
    cholesterol = json[SerializationKeys.cholesterol].float
    cholesterolPct = json[SerializationKeys.cholesterolPct].float
    satFat = json[SerializationKeys.satFat].float
    singularYieldUnit = json[SerializationKeys.singularYieldUnit].string
    totalFatPct = json[SerializationKeys.totalFatPct].float
    totalCarbsPct = json[SerializationKeys.totalCarbsPct].float
    dietaryFiberPct = json[SerializationKeys.dietaryFiberPct].float
    sodiumPct = json[SerializationKeys.sodiumPct].float
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = sodium { dictionary[SerializationKeys.sodium] = value }
    if let value = dietaryFiber { dictionary[SerializationKeys.dietaryFiber] = value }
    if let value = totalCalories { dictionary[SerializationKeys.totalCalories] = value }
    if let value = protein { dictionary[SerializationKeys.protein] = value }
    if let value = polyFat { dictionary[SerializationKeys.polyFat] = value }
    if let value = totalFat { dictionary[SerializationKeys.totalFat] = value }
    if let value = potassiumPct { dictionary[SerializationKeys.potassiumPct] = value }
    if let value = sugar { dictionary[SerializationKeys.sugar] = value }
    if let value = transFat { dictionary[SerializationKeys.transFat] = value }
    if let value = potassium { dictionary[SerializationKeys.potassium] = value }
    if let value = caloriesFromFat { dictionary[SerializationKeys.caloriesFromFat] = value }
    if let value = proteinPct { dictionary[SerializationKeys.proteinPct] = value }
    if let value = satFatPct { dictionary[SerializationKeys.satFatPct] = value }
    if let value = monoFat { dictionary[SerializationKeys.monoFat] = value }
    if let value = totalCarbs { dictionary[SerializationKeys.totalCarbs] = value }
    if let value = cholesterol { dictionary[SerializationKeys.cholesterol] = value }
    if let value = cholesterolPct { dictionary[SerializationKeys.cholesterolPct] = value }
    if let value = satFat { dictionary[SerializationKeys.satFat] = value }
    if let value = singularYieldUnit { dictionary[SerializationKeys.singularYieldUnit] = value }
    if let value = totalFatPct { dictionary[SerializationKeys.totalFatPct] = value }
    if let value = totalCarbsPct { dictionary[SerializationKeys.totalCarbsPct] = value }
    if let value = dietaryFiberPct { dictionary[SerializationKeys.dietaryFiberPct] = value }
    if let value = sodiumPct { dictionary[SerializationKeys.sodiumPct] = value }
    return dictionary
  }

}
