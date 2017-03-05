//
//  RecipeSearchViewController.swift
//  SousChef
//
//  Created by Kevin Nguyen on 3/4/17.
//  Copyright © 2017 Wilson Ding. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class RecipeSearchViewController: UIViewController {
    
    var API_KEY: String = ""
    var recipeSearchResults: RecipeSearch = RecipeSearch()
    
    @IBOutlet weak var recipeSearchTextField: UITextField!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getKeyFromPlist()
        
    }
    
    private func getKeyFromPlist() {
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            let dictRoot = NSDictionary(contentsOfFile: path)
            
            if let dict = dictRoot {
                API_KEY = dict["api_key"] as! String
            }
        }
    }
    
    func getRecipes(query: String) {
        
        let normalizedQuery = query.replacingOccurrences(of: " ", with: "+") // Normalized the data.
        
        let url = "http://api2.bigoven.com/recipes?pg=1&rpp=25&title_kw=\(normalizedQuery)&api_key=\(API_KEY)"
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.recipeSearchResults = RecipeSearch(json: json)
                self.performSegue(withIdentifier: "goToRecipeResults", sender: self)
            case .failure(let error):
                print(error)
            }
        }
        
        print(query)
        
    }
    
    @IBAction func didPressSearchButton(_ sender: UIButton) {
        let query = recipeSearchTextField.text!
        
        if (query != "") {
            getRecipes(query: query);
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(self.recipeSearchResults.resultCount)
        if segue.identifier == "goToRecipeResults" {
            var nextScene =  segue.destination as! RecipeSearchResultsTableViewController
            
            nextScene.recipeSearchResults = self.recipeSearchResults
            // Pass the selected object to the new view controller.
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        
}
