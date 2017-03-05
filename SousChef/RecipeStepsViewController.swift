//
//  RecipeStepsViewController.swift
//  SousChef
//
//  Created by Wilson Ding on 3/4/17.
//  Copyright © 2017 Wilson Ding. All rights reserved.
//

import UIKit

class RecipeStepsViewController: UIViewController {

    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var upcomingActionLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    var currentStep = 0
    
    var isDone = false
    
    var timer = Timer()
    
    var instructions: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNext()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.getNext), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.timer.invalidate()
    }
    
    func getNext() {
        if !isDone {
            actionLabel.text = instructions[currentStep]
            
            if instructions.count > currentStep + 1 {
                currentStep += 1
                upcomingActionLabel.text = instructions[currentStep]
                if instructions.count == currentStep + 1 {
                    isDone = true
                }
            } else {
                currentStep = -1
                upcomingActionLabel.text = "Complete"
            }
        }
    }

}
