//
//  CornerRadiusModifier.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 9/11/22.
//

import Foundation
import SwiftUI

struct CornerRadiusModifier: ViewModifier {
    let radiusValue: CornerRadiusEnum
    func body(content: Content) -> some View {
        content
            .cornerRadius(CGFloat(radiusValue))
    }
}

extension View {
    func customCornerRadius( _ radiusValue: CornerRadiusEnum) -> some View { modifier(
        CornerRadiusModifier(radiusValue: radiusValue)
    )
    }
}
