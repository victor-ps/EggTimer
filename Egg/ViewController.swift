//
//  ViewController.swift
//  Egg
//
//  Created by Victor Andre de Paula e Silva on 4/6/2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = ["Soft": 5, "Medium": 10, "Hard": 15]
    var totalTime: Int = 0
    var secondsPassed: Int = 0
    
    var time = Timer()
    var player: AVAudioPlayer!
    
    
    
    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var countSecondsLabel: UILabel!
    @IBOutlet weak var eggTimerProgressBar: UIProgressView!
    
    
    
    @IBAction func eggChoicePressed(_ sender: UIButton) {
        resetTimer()
        let hardness = sender.currentTitle!
        time.invalidate()
        totalTime = eggTimes[hardness]!
        tittleLabel.text = "Your \(hardness)Egg is being prepared."
        
        
        
        time = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer (){
        if secondsPassed < totalTime {
            secondsPassed += 1
            countSecondsLabel.text = String(secondsPassed)
            eggTimerProgressBar.progress = Float(secondsPassed)/Float(totalTime)
            
        }else if  secondsPassed == totalTime {
            tittleLabel.text = "Done!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
            
            time.invalidate()
            secondsPassed = 0
            
            DispatchQueue.main.asyncAfter(deadline: .now()  + 5) {
                self.tittleLabel.text = "How do you like your eggs?"
                self.eggTimerProgressBar.progress = 0
                self.countSecondsLabel.text = "0"
                
            }
            
        }
    }
    func resetTimer(){
        totalTime = 0
        secondsPassed = 0
        
    }
}
