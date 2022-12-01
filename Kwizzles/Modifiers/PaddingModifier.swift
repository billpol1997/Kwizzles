//
//  PaddingModifier.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 9/11/22.
//

import SwiftUI

struct PaddingModifier: ViewModifier {
    let paddingType: Edge.Set
    let paddingValue: PaddingEnum
    func body(content: Content) -> some View {
        content
            .padding(paddingType, CGFloat(paddingValue))
    }
}

extension View {
    func customPadding(_ paddingType: Edge.Set, _ paddingValue: PaddingEnum) -> some View { modifier(
        PaddingModifier(paddingType: paddingType, paddingValue: paddingValue)
    )
    }
}

