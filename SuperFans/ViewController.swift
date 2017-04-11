//
//  ViewController.swift
//  SuperFans
//
//  Created by John Gallaugher on 4/10/17.
//  Copyright © 2017 Gallaugher. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    let numberOfImages = 4
    var currentImage = 0
    var originalY: CGFloat = 0 // You could also have set this as an optional
    var audioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var equipmentImage: UIImageView!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var fightSongTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originalY = equipmentImage.frame.origin.y
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer) {
        if let sound = NSDataAsset(name: soundName) {
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("ERROR: Data from \(soundName) could not be played as an audio file")
            }
        } else {
            print("ERROR: Could not load datea from file \(soundName)")
        }
    }
    

    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        
        currentImage = currentImage + 1
        if currentImage == numberOfImages {
            currentImage = 0
        }
        equipmentImage.image = UIImage(named: "image\(currentImage)")
    }

    @IBAction func imageSwipped(_ sender: UISwipeGestureRecognizer) {
        
        UIView.animate(withDuration: 1, animations: {self.equipmentImage.frame.origin.y = -(self.equipmentImage.bounds.size.height)}, completion: {boolValue in
            self.resetButton.isHidden = false
            self.playSound(soundName: "sound0", audioPlayer: &self.audioPlayer)
            self.fightSongTextView.isHidden = false
        })
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        
        equipmentImage.frame.origin.y = originalY
        
        //UIView.animate(withDuration: 0, animations: {self.equipmentImage.frame.origin.y = self.originalY}, completion: nil)
        resetButton.isHidden = true
        audioPlayer.stop()
        fightSongTextView.isHidden = true
    }
}

