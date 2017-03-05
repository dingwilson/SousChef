//
//  RecipeOverviewViewController.swift
//  SousChef
//
//  Created by Wilson Ding on 3/4/17.
//  Copyright © 2017 Wilson Ding. All rights reserved.
//

import UIKit

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
    
    var results = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeTextView.text = recipe.instructions
        
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
        
        // Do any additional setup after loading the view.
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
