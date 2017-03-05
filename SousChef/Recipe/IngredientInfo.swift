//
//  IngredientInfo.swift
//
//  Created by Wilson Ding on 3/4/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class IngredientInfo {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let department = "Department"
    static let usuallyOnHand = "UsuallyOnHand"
    static let name = "Name"
    static let masterIngredientID = "MasterIngredientID"
  }

  // MARK: Properties
  public var department: String?
  public var usuallyOnHand: Bool? = false
  public var name: String?
  public var masterIngredientID: Int?

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
    department = json[SerializationKeys.department].string
    usuallyOnHand = json[SerializationKeys.usuallyOnHand].boolValue
    name = json[SerializationKeys.name].string
    masterIngredientID = json[SerializationKeys.masterIngredientID].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = department { dictionary[SerializationKeys.department] = value }
    dictionary[SerializationKeys.usuallyOnHand] = usuallyOnHand
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = masterIngredientID { dictionary[SerializationKeys.masterIngredientID] = value }
    return dictionary
  }

}
