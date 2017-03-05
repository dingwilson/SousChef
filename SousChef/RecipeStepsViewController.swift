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
    
    var timerTime = 0
    
    var instructions: [String] = [String]()
    
    let mySynthesizer = AVSpeechSynthesizer()
    
    var speechToText: SpeechToText!
    let assistantTriggerWords: [String] = ["sue", "soon", "slew", "suit", "suse", "Sir", "so"]
    var triggered: Bool = true
    var lastCount: Int = 0
    var timerStarted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getKeyFromPlist()
        getNext()
        
        timeLabel.isHidden = true
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
        speak(data: instructions[currentStep])
        
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
        }
        
        actionLabel.text = instructions[currentStep]

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
                    
                    if (results.bestTranscript.contains("set a timer" ) || results.bestTranscript.contains("set a time there" ) || results.bestTranscript.contains("Susanna timer" )) {
                        if (results.bestTranscript.contains("minutes") || results.bestTranscript.contains("minute")) {
                            
                            let nums = [ "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen"]
                            
                            let splitResults = results.bestTranscript.components(separatedBy: " ")
                            
                            for word in splitResults {
                                if nums.contains(word) {
                                    let numberResult = self.convertNumber(number: word)
                                    if (!self.timerStarted) {
                                        self.startTimer(num: numberResult)
                                    }
                                }
                            }
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
    
    func startTimer(num: Int) {
        self.timerStarted = true
        self.timeLabel.isHidden = false
        
        self.timerTime = num
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.runTimer), userInfo: nil, repeats: true)
    }
    
    func runTimer() {
        if timerTime > 0 {
            timerTime -= 1
            
            var displayValue = ""
            
            if floor(Double(timerTime/60)) < 10 {
                displayValue += "0\(floor(Double(timerTime/60)))"
            } else {
                displayValue += "\(floor(Double(timerTime/60)))"
            }
            
            if timerTime%60 < 10 {
                displayValue += ":0\(timerTime%60)"
            } else {
                displayValue += ":\(timerTime%60)"
            }
        } else {
            timerTime = 0
            timer.invalidate()
            timeLabel.isHidden = true
        }
    }
    
    func stopStreaming() {
        speechToText.stopRecognizeMicrophone()
    }

    func convertNumber(number: String) -> Int {
        if (number == "one") {
            return 1
        } else if (number == "two") {
            return 2
        } else if (number == "three") {
            return 3
        } else if (number == "four") {
            return 4
        } else if (number == "five") {
            return 5
        } else if (number == "six") {
            return 6
        } else if (number == "seven") {
            return 7
        } else if (number == "eight") {
            return 8
        } else if (number == "nine") {
            return 9
        }else if (number == "ten") {
            return 10
        }else if (number == "eleven") {
            return 11
        }else if (number == "twelve") {
            return 12
        }else if (number == "thirteen") {
            return 13
        }else if (number == "fourteen") {
            return 14
        }else if (number == "fifteen") {
            return 15
        }else if (number == "sixteen") {
            return 16
        }else if (number == "seventeen") {
            return 17
        }else if (number == "eightteen") {
            return 18
        }else if (number == "nineteen") {
            return 19
        }else if (number == "twenty") {
            return 20
        }else if (number == "twenty one") {
            return 21
        }else if (number == "twenty two") {
            return 22
        }else if (number == "twenty three") {
            return 23
        }else if (number == "twenty four") {
            return 24
        }else if (number == "twenty five") {
            return 25
        }else if (number == "twenty six") {
            return 26
        }else if (number == "twenty seven") {
            return 27
        }else if (number == "twenty eight") {
            return 28
        }else if (number == "twenty nine") {
            return 29
        }else if (number == "thirty") {
            return 30
        }
        
        return 30
    }
}
