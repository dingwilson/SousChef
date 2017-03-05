//
//  Ingredients.swift
//
//  Created by Wilson Ding on 3/4/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Ingredients {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let ingredientID = "IngredientID"
    static let hTMLName = "HTMLName"
    static let metricQuantity = "MetricQuantity"
    static let displayIndex = "DisplayIndex"
    static let metricDisplayQuantity = "MetricDisplayQuantity"
    static let isHeading = "IsHeading"
    static let metricUnit = "MetricUnit"
    static let name = "Name"
    static let quantity = "Quantity"
    static let isLinked = "IsLinked"
    static let ingredientInfo = "IngredientInfo"
  }

  // MARK: Properties
  public var ingredientID: Int?
  public var hTMLName: String?
  public var metricQuantity: Int?
  public var displayIndex: Int?
  public var metricDisplayQuantity: String?
  public var isHeading: Bool? = false
  public var metricUnit: String?
  public var name: String?
  public var quantity: Int?
  public var isLinked: Bool? = false
  public var ingredientInfo: IngredientInfo?

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
    ingredientID = json[SerializationKeys.ingredientID].int
    hTMLName = json[SerializationKeys.hTMLName].string
    metricQuantity = json[SerializationKeys.metricQuantity].int
    displayIndex = json[SerializationKeys.displayIndex].int
    metricDisplayQuantity = json[SerializationKeys.metricDisplayQuantity].string
    isHeading = json[SerializationKeys.isHeading].boolValue
    metricUnit = json[SerializationKeys.metricUnit].string
    name = json[SerializationKeys.name].string
    quantity = json[SerializationKeys.quantity].int
    isLinked = json[SerializationKeys.isLinked].boolValue
    ingredientInfo = IngredientInfo(json: json[SerializationKeys.ingredientInfo])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = ingredientID { dictionary[SerializationKeys.ingredientID] = value }
    if let value = hTMLName { dictionary[SerializationKeys.hTMLName] = value }
    if let value = metricQuantity { dictionary[SerializationKeys.metricQuantity] = value }
    if let value = displayIndex { dictionary[SerializationKeys.displayIndex] = value }
    if let value = metricDisplayQuantity { dictionary[SerializationKeys.metricDisplayQuantity] = value }
    dictionary[SerializationKeys.isHeading] = isHeading
    if let value = metricUnit { dictionary[SerializationKeys.metricUnit] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = quantity { dictionary[SerializationKeys.quantity] = value }
    dictionary[SerializationKeys.isLinked] = isLinked
    if let value = ingredientInfo { dictionary[SerializationKeys.ingredientInfo] = value.dictionaryRepresentation() }
    return dictionary
  }

}
