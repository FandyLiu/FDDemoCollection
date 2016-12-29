//
//  ViewController.swift
//  Timer
//
//  Created by QianTuFD on 2016/12/28.
//  Copyright © 2016年 fandy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    
    var counter = 0.0
    var timer = Timer()
    var isPlaying = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = String(counter)
        pauseButton.isEnabled = false
        
    }
    
    
    @IBAction func startTimer(_ sender: UIButton) {
        if isPlaying {
            return
        }
        startButton.isEnabled = false
        pauseButton.isEnabled = true
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        isPlaying = true
    }


    
    @IBAction func pauseTimer(_ sender: UIButton) {
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        timer.invalidate()
        isPlaying = false
        counter = 0.0
        timeLabel.text = String(counter)
    }
    
    @IBAction func resetTimer(_ sender: UIButton) {
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        
        timer.invalidate()
        isPlaying = false
        counter = 0.0
        timeLabel.text = String(counter)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTimer() -> Void {
        counter = counter + 0.1
        timeLabel.text = String(format: "%.1f", counter)
    }


}

