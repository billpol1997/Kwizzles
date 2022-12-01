//
//  CornerRadiusEnum.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 9/11/22.
//

import SwiftUI

enum CornerRadiusEnum{
    case playButtonRadius
    case questionRadius
    case answerRadius
    
    
    var radius: CGFloat{
        switch self{
        case .answerRadius:
            return 22
        case .playButtonRadius:
            return 25
        case .questionRadius:
            return 40
        }
    }
}
