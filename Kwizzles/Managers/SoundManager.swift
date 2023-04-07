//
//  SoundManager.swift
//  Kwizzles
//
//  Created by Bill on 7/4/23.
//

import Foundation
import AVKit
import SwiftUI

final class SoundManager {
    
    static let shared = SoundManager()
    var player: AVAudioPlayer?
    
    func playSound(sound: SoundsEnum, val: Bool ) {
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            if !val {
                player?.stop()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
