//
//  RecipeSearchViewController.swift
//  SousChef
//
//  Created by Kevin Nguyen on 3/4/17.
//  Copyright © 2017 Wilson Ding. All rights reserved.
//

import UIKit

class RecipeSearchViewController: UIViewController {

    @IBOutlet weak var recipeSearchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            let dictRoot = NSDictionary(contentsOfFile: path)
            
            if let dict = dictRoot {
                let api_key = dict["api_key"] as! String
            }
        }

    }

    @IBAction func didPressSearchButton(_ sender: Any) {
        
    }
    

}
