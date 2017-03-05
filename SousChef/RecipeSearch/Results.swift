//
//  Results.swift
//
//  Created by Wilson Ding on 3/4/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Results {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let webURL = "WebURL"
    static let poster = "Poster"
    static let reviewCount = "ReviewCount"
    static let isBookmark = "IsBookmark"
    static let servings = "Servings"
    static let microcategory = "Microcategory"
    static let title = "Title"
    static let starRating = "StarRating"
    static let creationDate = "CreationDate"
    static let isPrivate = "IsPrivate"
    static let recipeID = "RecipeID"
    static let category = "Category"
    static let isRecipeScan = "IsRecipeScan"
    static let totalTries = "TotalTries"
    static let photoUrl = "PhotoUrl"
    static let subcategory = "Subcategory"
    static let cuisine = "Cuisine"
  }

  // MARK: Properties
  public var webURL: String?
  public var poster: Poster?
  public var reviewCount: Int?
  public var isBookmark: Bool? = false
  public var servings: Int?
  public var microcategory: String?
  public var title: String?
  public var starRating: Float?
  public var creationDate: String?
  public var isPrivate: Bool? = false
  public var recipeID: Int?
  public var category: String?
  public var isRecipeScan: Bool? = false
  public var totalTries: Int?
  public var photoUrl: String?
  public var subcategory: String?
  public var cuisine: String?

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
    webURL = json[SerializationKeys.webURL].string
    poster = Poster(json: json[SerializationKeys.poster])
    reviewCount = json[SerializationKeys.reviewCount].int
    isBookmark = json[SerializationKeys.isBookmark].boolValue
    servings = json[SerializationKeys.servings].int
    microcategory = json[SerializationKeys.microcategory].string
    title = json[SerializationKeys.title].string
    starRating = json[SerializationKeys.starRating].float
    creationDate = json[SerializationKeys.creationDate].string
    isPrivate = json[SerializationKeys.isPrivate].boolValue
    recipeID = json[SerializationKeys.recipeID].int
    category = json[SerializationKeys.category].string
    isRecipeScan = json[SerializationKeys.isRecipeScan].boolValue
    totalTries = json[SerializationKeys.totalTries].int
    photoUrl = json[SerializationKeys.photoUrl].string
    subcategory = json[SerializationKeys.subcategory].string
    cuisine = json[SerializationKeys.cuisine].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = webURL { dictionary[SerializationKeys.webURL] = value }
    if let value = poster { dictionary[SerializationKeys.poster] = value.dictionaryRepresentation() }
    if let value = reviewCount { dictionary[SerializationKeys.reviewCount] = value }
    dictionary[SerializationKeys.isBookmark] = isBookmark
    if let value = servings { dictionary[SerializationKeys.servings] = value }
    if let value = microcategory { dictionary[SerializationKeys.microcategory] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = starRating { dictionary[SerializationKeys.starRating] = value }
    if let value = creationDate { dictionary[SerializationKeys.creationDate] = value }
    dictionary[SerializationKeys.isPrivate] = isPrivate
    if let value = recipeID { dictionary[SerializationKeys.recipeID] = value }
    if let value = category { dictionary[SerializationKeys.category] = value }
    dictionary[SerializationKeys.isRecipeScan] = isRecipeScan
    if let value = totalTries { dictionary[SerializationKeys.totalTries] = value }
    if let value = photoUrl { dictionary[SerializationKeys.photoUrl] = value }
    if let value = subcategory { dictionary[SerializationKeys.subcategory] = value }
    if let value = cuisine { dictionary[SerializationKeys.cuisine] = value }
    return dictionary
  }

}
