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
    
    var username = ""
    var password = ""
    
    var currentStep = 0
    
    var isDone = false
    
    var timer = Timer()
    
    var instructions: [String] = [String]()
    
    let mySynthesizer = AVSpeechSynthesizer()
    
    var speechToText: SpeechToText?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNext()
        
        startStreaming()
        
    }
    
    private func getKeyFromPlist() {
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            let dictRoot = NSDictionary(contentsOfFile: path)
            
            if let dict = dictRoot {
                username = dict["wat_pass"] as! String
                password = dict["wat_pass"] as! String
                self.speechToText = SpeechToText(username: username, password: password)
            }
        }
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
            if instructions[currentStep].range(of: "http") == nil {
                speak(data: instructions[currentStep])
            }
            
            if instructions.count > currentStep + 1 {
                currentStep += 1
                upcomingActionLabel.text = instructions[currentStep]
                if instructions.count <= currentStep + 1 {
                    isDone = true
                }
            }
        } else {
            if instructions.count == currentStep + 1 {
                if instructions[currentStep].range(of: "http") == nil {
                    speak(data: instructions[currentStep])
                }
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

    func startStreaming() {
        var settings = RecognitionSettings(contentType: .opus)
        settings.continuous = true
        settings.interimResults = true
        let failure = { (error: Error) in print(error) }
        speechToText?.recognizeMicrophone(settings: settings, failure: failure) { results in
            print(results)
        }
    }
    
    func stopStreaming() {
        speechToText?.stopRecognizeMicrophone()
    }

}
