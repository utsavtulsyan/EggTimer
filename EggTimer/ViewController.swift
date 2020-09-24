//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = [ "Soft": 5, "Medium": 7, "Hard":12 ]
    
    var player: AVAudioPlayer?
    
    var total: Float = 0.0
    var counter: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle
        guard hardness != nil else {
            return
        }
        
        let time = eggTimes[hardness!]
        
        if let time = time {
            total = Float(time) * 1.0
            counter = 0
        }
        
    }
    
    @objc func updateCounter(){
        if (counter < total){
            counter += 1
            progressView.setProgress( Float(counter/total), animated: true)
            if (counter == total){
                playSound()
            }
        }
        
    }
    
    func playSound(){
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
                guard let player = player else { return }
                player.play()

            } catch let error {
                print(error.localizedDescription)
            }
    }
    

}
