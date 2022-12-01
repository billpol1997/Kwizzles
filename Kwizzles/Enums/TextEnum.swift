//
//  TextEnum.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 9/11/22.
//

import SwiftUI


enum TextEnum{
    case kwiz
    case slogan
    case press
    case play
    case score
    case playAgain
    case gameOver
    
    var string: String{
        switch self{
        case .kwiz:
            return "Kwizzles"
        case .slogan:
            return "Learn about the world"
        case .press:
            return "Press Play to start"
        case .play:
            return "Play"
        case .score:
            return "Your Score is"
        case .playAgain:
            return "Play Again"
        case .gameOver:
            return "Game Over!"
        }
    }
}
