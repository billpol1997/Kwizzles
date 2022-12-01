//
//  WidthsEnum.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 9/11/22.
//

import SwiftUI

enum WidthsEnum{
    case zero
    case logoWidth
    case playButtonWidth
    case questionWidth
    case answerWidth
    case timerWidth
    
    
    var width: CGFloat{
        switch self{
        case .zero:
            return 0
        case .timerWidth:
            return 70
        case .logoWidth:
            return 101.4
        case .answerWidth:
            return 184
        case .playButtonWidth:
            return 240
        case .questionWidth:
            return 365
        }
    }
}
