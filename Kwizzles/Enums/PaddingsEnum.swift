//
//  PaddingsEnum.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 9/11/22.
//

import SwiftUI

enum PaddingEnum{
    case playButtonInnerBottomPadding
    case welcomeScreenTextsPadding
    case welcomeScreenTextsPaddingAlt
    case questionContainerHorizontalPadding,questionContainerVerticalPadding
    case gameHorizontalPadding
    case gameVerticalPadding
    case questionContainerMiddlePadding
    
    var padding: CGFloat{
        switch self{
        case .questionContainerVerticalPadding,.questionContainerMiddlePadding:
            return 10
        case .playButtonInnerBottomPadding:
            return 10
        case .welcomeScreenTextsPadding:
            return 28
        case .welcomeScreenTextsPaddingAlt:
            return 25
        case .questionContainerHorizontalPadding,.gameHorizontalPadding:
            return 20
        case .gameVerticalPadding:
            return 10
        }
    }
}
