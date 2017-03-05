//
//  SplashViewController.swift
//  SousChef
//
//  Created by Wilson Ding on 3/4/17.
//  Copyright © 2017 Wilson Ding. All rights reserved.
//

import UIKit
import SwiftVideoBackground

class SplashViewController: UIViewController {

    @IBOutlet weak var backgroundVideo: BackgroundVideo!
    @IBOutlet weak var beginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundVideo.createBackgroundVideo(name: "Background", type: "mp4")
        
        beginButton.layer.cornerRadius = 8
        beginButton.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1.5, animations: {
            self.beginButton.alpha = 1.0
        })
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
