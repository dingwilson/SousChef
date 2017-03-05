//
//  RecipeStepsViewController.swift
//  SousChef
//
//  Created by Wilson Ding on 3/4/17.
//  Copyright © 2017 Wilson Ding. All rights reserved.
//

import UIKit
import AVFoundation
import SpeechToTextV1 // https://github.com/watson-developer-cloud/swift-sdk#speech-to-text

class RecipeStepsViewController: UIViewController {

    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var upcomingActionLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    var currentStep = 0
    
    var isDone = false
    
    var timer = Timer()
    
    var instructions: [String] = [String]()
    
    let mySynthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNext()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.getNext), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.timer.invalidate()
    }
    
    func getNext() {
        if !isDone {
            actionLabel.text = instructions[currentStep]
            speak(data: instructions[currentStep])
            
            if instructions.count > currentStep + 1 {
                currentStep += 1
                upcomingActionLabel.text = instructions[currentStep]
                if instructions.count <= currentStep + 1 {
                    isDone = true
                }
            }
        } else {
            if instructions.count == currentStep + 1 {
                speak(data: instructions[currentStep])
            }
            
            self.timer.invalidate()
        }
    }
    
    func speak(data: String) {
        let myUtterence = AVSpeechUtterance(string: data)
        myUtterence.rate = AVSpeechUtteranceDefaultSpeechRate
        myUtterence.voice = AVSpeechSynthesisVoice(language: "en-US")
        myUtterence.pitchMultiplier = 1
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        }
        catch let error as NSError {
            print("Error: Could not set audio category: \(error), \(error.userInfo)")
        }
        
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch let error as NSError {
            print("Error: Could not setActive to true: \(error), \(error.userInfo)")
        }
        
        mySynthesizer.speak(myUtterence)
    }

}
