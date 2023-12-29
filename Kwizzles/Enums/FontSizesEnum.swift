//
//  FontSizesEnum.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 9/11/22.
//

import SwiftUI

enum FontSizesEnum {
    case maxFont
    case hugeFont
    case mediumFont
    case mediumMaxFont
    case bigFont
    case smallFont
    case tinyFont
    
    var size: CGFloat {
        switch self {
        case .tinyFont:
            return 15
        case .smallFont:
            return 18
        case .maxFont:
            return 72
        case .mediumFont:
            return 26
        case .mediumMaxFont:
            return 28
        case .bigFont:
            return 36
        case .hugeFont:
            return 50
        }
    }
}
