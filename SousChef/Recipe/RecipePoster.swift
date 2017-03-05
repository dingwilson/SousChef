//
//  Poster.swift
//
//  Created by Wilson Ding on 3/4/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class RecipePoster {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let userName = "UserName"
    static let premiumExpiryDate = "PremiumExpiryDate"
    static let isUsingRecurly = "IsUsingRecurly"
    static let userID = "UserID"
    static let photoUrl = "PhotoUrl"
    static let memberSince = "MemberSince"
    static let isKitchenHelper = "IsKitchenHelper"
    static let isPremium = "IsPremium"
  }

  // MARK: Properties
  public var userName: String?
  public var premiumExpiryDate: String?
  public var isUsingRecurly: Bool? = false
  public var userID: Int?
  public var photoUrl: String?
  public var memberSince: String?
  public var isKitchenHelper: Bool? = false
  public var isPremium: Bool? = false

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
    userName = json[SerializationKeys.userName].string
    premiumExpiryDate = json[SerializationKeys.premiumExpiryDate].string
    isUsingRecurly = json[SerializationKeys.isUsingRecurly].boolValue
    userID = json[SerializationKeys.userID].int
    photoUrl = json[SerializationKeys.photoUrl].string
    memberSince = json[SerializationKeys.memberSince].string
    isKitchenHelper = json[SerializationKeys.isKitchenHelper].boolValue
    isPremium = json[SerializationKeys.isPremium].boolValue
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = userName { dictionary[SerializationKeys.userName] = value }
    if let value = premiumExpiryDate { dictionary[SerializationKeys.premiumExpiryDate] = value }
    dictionary[SerializationKeys.isUsingRecurly] = isUsingRecurly
    if let value = userID { dictionary[SerializationKeys.userID] = value }
    if let value = photoUrl { dictionary[SerializationKeys.photoUrl] = value }
    if let value = memberSince { dictionary[SerializationKeys.memberSince] = value }
    dictionary[SerializationKeys.isKitchenHelper] = isKitchenHelper
    dictionary[SerializationKeys.isPremium] = isPremium
    return dictionary
  }

}
