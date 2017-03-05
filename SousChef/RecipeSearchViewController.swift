//
//  RecipeSearchViewController.swift
//  SousChef
//
//  Created by Kevin Nguyen on 3/4/17.
//  Copyright © 2017 Wilson Ding. All rights reserved.
//

import UIKit

class RecipeSearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            let dictRoot = NSDictionary(contentsOfFile: path)
            
            if let dict = dictRoot {
                let api_key = dict["api_key"] as! String
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
