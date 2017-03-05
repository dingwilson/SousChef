//
//  RecipeOverviewViewController.swift
//  SousChef
//
//  Created by Wilson Ding on 3/4/17.
//  Copyright © 2017 Wilson Ding. All rights reserved.
//

import UIKit
import SDWebImage

enum typeOfInstruction {
    case period // All the instructions are delimited by periods and no numbers.
    case number
    case letter
    case newline
    case bullet // Default case.
}

class RecipeOverviewViewController: UIViewController {
    
    var recipe: Recipe = Recipe()
    
    @IBOutlet weak var recipeTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var beginRecipeButton: UIButton!
    
    var results = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeTextView.text = recipe.instructions
        
        beginRecipeButton.layer.cornerRadius = 8
        
        imageView.sd_setImage(with: URL(string: self.recipe.photoUrl!), placeholderImage: UIImage(named: "TransparentIcon"))

        imageView.layer.borderWidth = 1.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.clipsToBounds = true
        
        titleLabel.text = recipe.title
        
        descriptionLabel.text = recipe.description
        
        var ingredientsList = "Ingredients: "
        
        for ingredient in recipe.ingredients! {
            if ingredientsList != "Ingredients: " {
                ingredientsList += ", "
            }
            
            ingredientsList += (ingredient.name?.capitalizingFirstLetter())!
        }
        
        ingredientsLabel.text = ingredientsList
        
        let temp = recipe.instructions?.components(separatedBy: ". ")
        
        for t in temp! { // For each instruction
            let te = t.components(separatedBy: "\n")
            
            for i in te {
                if (i.characters.count > 3) {
                    let trimmedString = i.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                     results.append(trimmedString)
                }
            }
        }
        // Do anything with results here.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToInstructions" {
            let nextScene =  segue.destination as! RecipeStepsViewController
            nextScene.instructions = self.results
        }
    }
    
    @IBAction func goButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goToInstructions", sender: self)
    }
    
}
