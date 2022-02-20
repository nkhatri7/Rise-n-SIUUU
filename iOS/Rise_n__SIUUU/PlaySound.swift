//
//  PlaySound.swift
//  Rise-n-SIUUU
//
//  Created by Neil Khatri on 20/2/22.
//

import Foundation
import AVFoundation

var player : AVAudioPlayer!

func playSound() {
    // Enabling sound to play while silent mode is on
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback)
    } catch {
        print(error.localizedDescription)
    }
    
    let url = Bundle.main.url(forResource: "SIUUU_Audio", withExtension: "mp3")
    
    // Do nothing if url is empty
    guard url != nil else {
        return
    }
    
    do {
        // Play sound
        player = try AVAudioPlayer(contentsOf: url!)
        player?.play()
    } catch {
        print(error.localizedDescription)
    }
}
