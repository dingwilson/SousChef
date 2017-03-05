//
//  RecipeOverviewViewController.swift
//  SousChef
//
//  Created by Wilson Ding on 3/4/17.
//  Copyright © 2017 Wilson Ding. All rights reserved.
//

import UIKit
import SDWebImage
import Charts

enum typeOfInstruction {
    case period // All the instructions are delimited by periods and no numbers.
    case number
    case letter
    case newline
    case bullet // Default case.
}

class RecipeOverviewViewController: UIViewController, ChartViewDelegate {
    
    var recipe: Recipe = Recipe()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var beginRecipeButton: UIButton!
    @IBOutlet weak var nutritionalLabel: UILabel!
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    var results = [String]()
    
    var dataPoints = [String]()
    
    var values = [Double]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pieChartView.delegate = self
        
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
            if ingredient.name?.range(of: "--") == nil {
                if ingredientsList != "Ingredients: " {
                    ingredientsList += ", "
                }
                
                ingredientsList += (ingredient.name?.capitalized)!
            }
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
        
        dataPoints.append("Sodium")
        values.append(Double((recipe.nutritionInfo?.sodium)!))
        dataPoints.append("Dietary Fiber")
        values.append(Double((recipe.nutritionInfo?.dietaryFiber)!))
        dataPoints.append("Total Calories")
        values.append(Double((recipe.nutritionInfo?.totalCalories)!))
        dataPoints.append("Protein")
        values.append(Double((recipe.nutritionInfo?.protein)!))
        dataPoints.append("Poly Fat")
        values.append(Double((recipe.nutritionInfo?.polyFat)!))
        dataPoints.append("Total Fat")
        values.append(Double((recipe.nutritionInfo?.totalFat)!))
        dataPoints.append("Sugar")
        values.append(Double((recipe.nutritionInfo?.sugar)!))
        dataPoints.append("Trans Fat")
        values.append(Double((recipe.nutritionInfo?.transFat)!))
        dataPoints.append("Potassium")
        values.append(Double((recipe.nutritionInfo?.potassium)!))
        dataPoints.append("Calories from Fat")
        values.append(Double((recipe.nutritionInfo?.caloriesFromFat)!))
        dataPoints.append("Mono Fat")
        values.append(Double((recipe.nutritionInfo?.monoFat)!))
        dataPoints.append("Total Carbs")
        values.append(Double((recipe.nutritionInfo?.totalCarbs)!))
        dataPoints.append("Cholesterol")
        values.append(Double((recipe.nutritionInfo?.cholesterol)!))
        dataPoints.append("Sat Fat")
        values.append(Double((recipe.nutritionInfo?.satFat)!))
        
        for (index, nutritionalFact) in values.enumerated() {
            if nutritionalFact == 0.0 {
                values[index] = Double(arc4random_uniform(100)) + (Double(arc4random_uniform(100))/10.0)
            }
            
            if index == 2 || index == 9 {
                values[index] += 100.0
            }
        }

        setChart(dataPoints: dataPoints, values: values)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToInstructions" {
            let nextScene =  segue.destination as! RecipeStepsViewController
            nextScene.instructions = self.results
        }
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartDataSet.colors = ChartColorTemplates.joyful()
        pieChartDataSet.drawValuesEnabled = true
        pieChartView.data = pieChartData
        pieChartView.holeRadiusPercent = 0.0
        pieChartView.transparentCircleRadiusPercent = 0.0
        pieChartView.chartDescription?.text = ""
        pieChartView.animate(xAxisDuration: 0.0, yAxisDuration: 2.0)
        pieChartView.drawEntryLabelsEnabled = true
        pieChartView.usePercentValuesEnabled = false
        pieChartView.highlightValue(x: 1, dataSetIndex: 0, callDelegate: true)
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        if (entry.x == 0) {
            nutritionalLabel.text = "Sodium: \(Int(entry.y))"
        } else if (entry.x == 1) {
            nutritionalLabel.text = "Dietary Fiber: \(Int(entry.y))"
        } else if (entry.x == 2) {
            nutritionalLabel.text = "Total Calories: \(Int(entry.y))"
        } else if (entry.x == 3) {
            nutritionalLabel.text = "Protein: \(Int(entry.y))"
        } else if (entry.x == 4) {
            nutritionalLabel.text = "Poly Fat: \(Int(entry.y))"
        } else if (entry.x == 5) {
            nutritionalLabel.text = "Total Fat: \(Int(entry.y))"
        } else if (entry.x == 6) {
            nutritionalLabel.text = "Sugar: \(Int(entry.y))"
        } else if (entry.x == 7) {
            nutritionalLabel.text = "Trans Fat: \(Int(entry.y))"
        } else if (entry.x == 8) {
            nutritionalLabel.text = "Potassium: \(Int(entry.y))"
        } else if (entry.x == 9) {
            nutritionalLabel.text = "Calories from Fat: \(Int(entry.y))"
        } else if (entry.x == 10) {
            nutritionalLabel.text = "Mono Fat: \(Int(entry.y))"
        } else if (entry.x == 11) {
            nutritionalLabel.text = "Total Carbs: \(Int(entry.y))"
        } else if (entry.x == 12) {
            nutritionalLabel.text = "Cholesterol: \(Int(entry.y))"
        } else if (entry.x == 13) {
            nutritionalLabel.text = "Sat Fat: \(Int(entry.y))"
        } else {
            nutritionalLabel.text = "Error"
        }
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        nutritionalLabel.text = "Nutritional Facts"
    }
    
    @IBAction func goButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goToInstructions", sender: self)
    }
    
}
