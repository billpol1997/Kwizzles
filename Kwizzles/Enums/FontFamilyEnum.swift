//
//  FontFamilyEnum.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 9/11/22.
//

import SwiftUI

enum FontFamilyEnum{
    case chalkBold
    case chalk
    case impact
    case arial
    
    var name: String{
        switch self{
        case .chalkBold:
            return "ChalkboardSE-Bold"
        case .chalk:
            return "ChalkboardSE-Regular"
        case .impact:
            return "Impact"
        case .arial:
            return "Arial"
        }
    }
}
