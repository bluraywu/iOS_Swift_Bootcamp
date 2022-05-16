//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var eggProgress: UIProgressView!
    let eggTimes = ["Soft":5,"Medium":7 * 60,"Hard":12 * 60]
    var timer = Timer()
    var player : AVAudioPlayer!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        eggProgress.progress = Float.zero
        let hardness = sender.currentTitle!
        question.text = hardness
        let timeCount = eggTimes[hardness] ?? 0
        var timePassed = Int.zero
        //print(time)
        timer=Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ timer in
            if (timePassed < timeCount) {
                timePassed += 1
                self.eggProgress.progress = Float(timePassed) / Float(timeCount)
                print("\(timePassed) seconds.")
            }else{
                self.question.text = "Done!"
                timer.invalidate()
                let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                self.player = try! AVAudioPlayer(contentsOf: url!)
                self.player.play()
            }
        }
    }
}
