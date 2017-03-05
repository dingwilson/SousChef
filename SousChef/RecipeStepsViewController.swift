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
    
    var speechToText: SpeechToText!
    let assistantTriggerWords: [String] = ["sue", "soon", "slew", "suit", "suse", "Sir", "so"]
    var triggered: Bool = true
    var lastCount: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getKeyFromPlist()
        getNext()

    }
    
    private func getKeyFromPlist() {
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            let dictRoot = NSDictionary(contentsOfFile: path)
            
            if let dict = dictRoot {
                username = dict["wat_key"] as! String
                password = dict["wat_pass"] as! String
                self.speechToText = SpeechToText(username: username, password: password)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.getNext), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.timer.invalidate()
    }
    
    func getNext() {
        
        self.stopStreaming()
        self.speechToText = SpeechToText(username: username, password: password)
        self.lastCount = 0
        self.startStreaming()
        actionLabel.text = instructions[currentStep]
//            speak(data: instructions[currentStep])
        
        if instructions.count > currentStep + 1 {
            currentStep += 1
            upcomingActionLabel.text = instructions[currentStep]
            if instructions.count <= currentStep + 1 {
                isDone = true
            }
        }
        
    }
    
    func getPrev() {
        
        self.stopStreaming()
        self.speechToText = SpeechToText(username: username, password: password)
        self.lastCount = 0
        self.startStreaming()
        
        if (currentStep - 1 >= 0) {
            currentStep -= 1
            if (currentStep == 0) {
                isDone = true
            }
        }
        
        actionLabel.text = instructions[currentStep]
        
//        if (!isDone && triggered) {
//            self.stopStreaming()
//            self.speechToText = SpeechToText(username: username, password: password)
//            self.lastCount = 0
//            self.startStreaming()
//            actionLabel.text = instructions[currentStep]
//            //            speak(data: instructions[currentStep])
//            
//            if (currentStep - 1 >= 0) {
//                currentStep -= 1
//                if (0 >= currentStep - 1) {
//                    isDone = true
//                }
//            }
//        } else {
//            if 0 == currentStep - 1 {
//                //speak(data: instructions[currentStep])
//            }
//            
//            self.timer.invalidate()
//        }
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
    
    var beforeStr: String = "";
    
    func startStreaming() {
        var settings = RecognitionSettings(contentType: .opus)
        settings.continuous = true
        settings.interimResults = true
        let failure = { (error: Error) in print(error) }
        speechToText.recognizeMicrophone(settings: settings, failure: failure) { results in
            let result = results.bestTranscript
            print(result)
            let res = result.components(separatedBy: " ")
            for word in res {
                
                if (self.assistantTriggerWords.contains(word)) {
                    self.triggered = false
                    print("Triggered.")
                    
                    if (results.bestTranscript.contains("set a timer" ) || results.bestTranscript.contains("set a time there" ) || results.bestTranscript.contains("Susanna timer" )) {
                        print("SETTING A TIMER!")
                        
                        if (results.bestTranscript.contains("minutes") || results.bestTranscript.contains("minute")) {
                            
                            let splitResults = results.bestTranscript.components(separatedBy: " ")
                            
                            var location = splitResults.contains("minutes")
                            
                            if (!location) {
                                location = splitResults.contains("minute")
                            }
                            self.triggered = true;
                            self.speechToText.stopRecognizeMicrophone();

                        }
                        
                    } else if (results.bestTranscript.contains("next") || results.bestTranscript.contains("forward")  || results.bestTranscript.contains("for")) {

                        if (self.lastCount != results.bestTranscript.characters.count) {
                            self.triggered = true;
                            self.speechToText.stopRecognizeMicrophone()
                            self.getNext()
                        }
                        
                        self.lastCount = results.bestTranscript.characters.count
                    }
                    else if (results.bestTranscript.contains("back") || results.bestTranscript.contains("previous")) {
                        print("PREVIOUS")
                        if (self.lastCount != results.bestTranscript.characters.count) {
                            self.triggered = true;
                            self.speechToText.stopRecognizeMicrophone()
                            self.getPrev()
                        }
                        
                        self.lastCount = results.bestTranscript.characters.count
                    }
                    
                }
            }
        }
    }
    
    func stopStreaming() {
        speechToText.stopRecognizeMicrophone()
    }

}
