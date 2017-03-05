//
//  RecipeTableViewCell.swift
//  SousChef
//
//  Created by Wilson Ding on 3/5/17.
//  Copyright © 2017 Wilson Ding. All rights reserved.
//

import UIKit
import Cosmos

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var starView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        recipeImageView.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
