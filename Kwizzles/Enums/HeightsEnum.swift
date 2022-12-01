//
//  HeightsEnum.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 9/11/22.
//

import SwiftUI

enum HeightsEnum{
    case zero
    case logoHeight
    case playButtonHeight
    case questionHeight
    case answerHeight
    case timerHeight
    
    var height: CGFloat{
        switch self{
        case .zero:
            return 0
        case .timerHeight:
            return 70
        case .logoHeight:
            return 89.99
        case .playButtonHeight:
            return 68
        case .answerHeight:
            return 128
        case .questionHeight:
            return 266
        }
    }
}
