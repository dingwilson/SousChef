//
//  RecipeSearchResultsTableViewController.swift
//  SousChef
//
//  Created by Wilson Ding on 3/4/17.
//  Copyright © 2017 Wilson Ding. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import Cosmos

class RecipeSearchResultsTableViewController: UITableViewController {
    
    var recipeSearchResults: RecipeSearch = RecipeSearch()
    var selectedRecipe: Recipe = Recipe()
    var selectedRow: Int = 0
    var API_KEY: String = ""
    
    private func getKeyFromPlist() {
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            let dictRoot = NSDictionary(contentsOfFile: path)
            
            if let dict = dictRoot {
                API_KEY = dict["api_key"] as! String
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getKeyFromPlist()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.recipeSearchResults.results!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! RecipeTableViewCell
        
        cell.recipeImageView?.sd_setImage(with: URL(string: (self.recipeSearchResults.results?[indexPath.row].photoUrl)!), placeholderImage: UIImage(named: "TransparentIcon"))
        
        cell.titleLabel?.text = self.recipeSearchResults.results?[indexPath.row].title
        
        cell.starView?.rating = Double((self.recipeSearchResults.results?[indexPath.row].starRating)!)
        
        cell.starView?.text = "(\((self.recipeSearchResults.results?[indexPath.row].reviewCount)!))"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        let id = self.recipeSearchResults.results?[indexPath.row].recipeID
        
        let url = "https://api2.bigoven.com/recipe/\(id!)?api_key=\(API_KEY)"
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.selectedRecipe = Recipe(json: json)
                self.performSegue(withIdentifier: "goToOverview", sender: self)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToOverview" {
            let nextScene =  segue.destination as! RecipeOverviewViewController
            nextScene.recipe = self.selectedRecipe
            // Pass the selected object to the new view controller.
        }
    }

}

extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print("Image Failed to Download")
                return
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
}
