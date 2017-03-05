//
//  Recipe.swift
//
//  Created by Wilson Ding on 3/4/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Recipe {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let collection = "Collection"
    static let poster = "Poster"
    static let adTags = "AdTags"
    static let yieldNumber = "YieldNumber"
    static let isBookmark = "IsBookmark"
    static let bookmarkSiteLogo = "BookmarkSiteLogo"
    static let isPrivate = "IsPrivate"
    static let starRating = "StarRating"
    static let creationDate = "CreationDate"
    static let imageURL = "ImageURL"
    static let ingredients = "Ingredients"
    static let totalMinutes = "TotalMinutes"
    static let recipeID = "RecipeID"
    static let notesCount = "NotesCount"
    static let category = "Category"
    static let isSponsored = "IsSponsored"
    static let subcategory = "Subcategory"
    static let nutritionInfo = "NutritionInfo"
    static let verifiedByClass = "VerifiedByClass"
    static let cuisine = "Cuisine"
    static let verifiedDateTime = "VerifiedDateTime"
    static let webURL = "WebURL"
    static let reviewCount = "ReviewCount"
    static let medalCount = "MedalCount"
    static let maxImageSquare = "MaxImageSquare"
    static let title = "Title"
    static let favoriteCount = "FavoriteCount"
    static let primaryIngredient = "PrimaryIngredient"
    static let yieldUnit = "YieldUnit"
    static let menuCount = "MenuCount"
    static let description = "Description"
    static let lastModified = "LastModified"
    static let allCategoriesText = "AllCategoriesText"
    static let imageSquares = "ImageSquares"
    static let instructions = "Instructions"
    static let photoUrl = "PhotoUrl"
    static let activeMinutes = "ActiveMinutes"
    static let adminBoost = "AdminBoost"
  }

  // MARK: Properties
  public var collection: String?
  public var poster: RecipePoster?
  public var adTags: String?
  public var yieldNumber: Int?
  public var isBookmark: Bool? = false
  public var bookmarkSiteLogo: String?
  public var isPrivate: Bool? = false
  public var starRating: Float?
  public var creationDate: String?
  public var imageURL: String?
  public var ingredients: [Ingredients]?
  public var totalMinutes: Int?
  public var recipeID: Int?
  public var notesCount: Int?
  public var category: String?
  public var isSponsored: Bool? = false
  public var subcategory: String?
  public var nutritionInfo: NutritionInfo?
  public var verifiedByClass: String?
  public var cuisine: String?
  public var verifiedDateTime: String?
  public var webURL: String?
  public var reviewCount: Int?
  public var medalCount: Int?
  public var maxImageSquare: Int?
  public var title: String?
  public var favoriteCount: Int?
  public var primaryIngredient: String?
  public var yieldUnit: String?
  public var menuCount: Int?
  public var description: String?
  public var lastModified: String?
  public var allCategoriesText: String?
  public var imageSquares: [Int]?
  public var instructions: String?
  public var photoUrl: String?
  public var activeMinutes: Int?
  public var adminBoost: Int?

    init() {
        
    }
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
    collection = json[SerializationKeys.collection].string
    poster = RecipePoster(json: json[SerializationKeys.poster])
    adTags = json[SerializationKeys.adTags].string
    yieldNumber = json[SerializationKeys.yieldNumber].int
    isBookmark = json[SerializationKeys.isBookmark].boolValue
    bookmarkSiteLogo = json[SerializationKeys.bookmarkSiteLogo].string
    isPrivate = json[SerializationKeys.isPrivate].boolValue
    starRating = json[SerializationKeys.starRating].float
    creationDate = json[SerializationKeys.creationDate].string
    imageURL = json[SerializationKeys.imageURL].string
    if let items = json[SerializationKeys.ingredients].array { ingredients = items.map { Ingredients(json: $0) } }
    totalMinutes = json[SerializationKeys.totalMinutes].int
    recipeID = json[SerializationKeys.recipeID].int
    notesCount = json[SerializationKeys.notesCount].int
    category = json[SerializationKeys.category].string
    isSponsored = json[SerializationKeys.isSponsored].boolValue
    subcategory = json[SerializationKeys.subcategory].string
    nutritionInfo = NutritionInfo(json: json[SerializationKeys.nutritionInfo])
    verifiedByClass = json[SerializationKeys.verifiedByClass].string
    cuisine = json[SerializationKeys.cuisine].string
    verifiedDateTime = json[SerializationKeys.verifiedDateTime].string
    webURL = json[SerializationKeys.webURL].string
    reviewCount = json[SerializationKeys.reviewCount].int
    medalCount = json[SerializationKeys.medalCount].int
    maxImageSquare = json[SerializationKeys.maxImageSquare].int
    title = json[SerializationKeys.title].string
    favoriteCount = json[SerializationKeys.favoriteCount].int
    primaryIngredient = json[SerializationKeys.primaryIngredient].string
    yieldUnit = json[SerializationKeys.yieldUnit].string
    menuCount = json[SerializationKeys.menuCount].int
    description = json[SerializationKeys.description].string
    lastModified = json[SerializationKeys.lastModified].string
    allCategoriesText = json[SerializationKeys.allCategoriesText].string
    if let items = json[SerializationKeys.imageSquares].array { imageSquares = items.map { $0.intValue } }
    instructions = json[SerializationKeys.instructions].string
    photoUrl = json[SerializationKeys.photoUrl].string
    activeMinutes = json[SerializationKeys.activeMinutes].int
    adminBoost = json[SerializationKeys.adminBoost].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = collection { dictionary[SerializationKeys.collection] = value }
    if let value = poster { dictionary[SerializationKeys.poster] = value.dictionaryRepresentation() }
    if let value = adTags { dictionary[SerializationKeys.adTags] = value }
    if let value = yieldNumber { dictionary[SerializationKeys.yieldNumber] = value }
    dictionary[SerializationKeys.isBookmark] = isBookmark
    if let value = bookmarkSiteLogo { dictionary[SerializationKeys.bookmarkSiteLogo] = value }
    dictionary[SerializationKeys.isPrivate] = isPrivate
    if let value = starRating { dictionary[SerializationKeys.starRating] = value }
    if let value = creationDate { dictionary[SerializationKeys.creationDate] = value }
    if let value = imageURL { dictionary[SerializationKeys.imageURL] = value }
    if let value = ingredients { dictionary[SerializationKeys.ingredients] = value.map { $0.dictionaryRepresentation() } }
    if let value = totalMinutes { dictionary[SerializationKeys.totalMinutes] = value }
    if let value = recipeID { dictionary[SerializationKeys.recipeID] = value }
    if let value = notesCount { dictionary[SerializationKeys.notesCount] = value }
    if let value = category { dictionary[SerializationKeys.category] = value }
    dictionary[SerializationKeys.isSponsored] = isSponsored
    if let value = subcategory { dictionary[SerializationKeys.subcategory] = value }
    if let value = nutritionInfo { dictionary[SerializationKeys.nutritionInfo] = value.dictionaryRepresentation() }
    if let value = verifiedByClass { dictionary[SerializationKeys.verifiedByClass] = value }
    if let value = cuisine { dictionary[SerializationKeys.cuisine] = value }
    if let value = verifiedDateTime { dictionary[SerializationKeys.verifiedDateTime] = value }
    if let value = webURL { dictionary[SerializationKeys.webURL] = value }
    if let value = reviewCount { dictionary[SerializationKeys.reviewCount] = value }
    if let value = medalCount { dictionary[SerializationKeys.medalCount] = value }
    if let value = maxImageSquare { dictionary[SerializationKeys.maxImageSquare] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = favoriteCount { dictionary[SerializationKeys.favoriteCount] = value }
    if let value = primaryIngredient { dictionary[SerializationKeys.primaryIngredient] = value }
    if let value = yieldUnit { dictionary[SerializationKeys.yieldUnit] = value }
    if let value = menuCount { dictionary[SerializationKeys.menuCount] = value }
    if let value = description { dictionary[SerializationKeys.description] = value }
    if let value = lastModified { dictionary[SerializationKeys.lastModified] = value }
    if let value = allCategoriesText { dictionary[SerializationKeys.allCategoriesText] = value }
    if let value = imageSquares { dictionary[SerializationKeys.imageSquares] = value }
    if let value = instructions { dictionary[SerializationKeys.instructions] = value }
    if let value = photoUrl { dictionary[SerializationKeys.photoUrl] = value }
    if let value = activeMinutes { dictionary[SerializationKeys.activeMinutes] = value }
    if let value = adminBoost { dictionary[SerializationKeys.adminBoost] = value }
    return dictionary
  }

}
