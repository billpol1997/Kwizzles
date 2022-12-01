//
//  FontModifier.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 9/11/22.
//

import SwiftUI
import Foundation

struct FontModifier: ViewModifier {
    let fontName: FontFamilyEnum
    let fontSizeValue: FontSizesEnum
    
    func body(content: Content) -> some View {
        content
            .font(.custom(fontName.name, size: fontSizeValue.size))
    }
}

extension View {
    func customFont(_ fontName: FontFamilyEnum, _ fontSizeValue: FontSizesEnum) -> some View { modifier(
        FontModifier(fontName: fontName, fontSizeValue: fontSizeValue )
    )
    }
}
