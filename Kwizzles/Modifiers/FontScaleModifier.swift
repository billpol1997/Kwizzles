//
//  FontScaleModifier.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 9/11/22.
//

import SwiftUI


struct FontScaleModifier: AnimatableModifier {
  private var percentage: CGFloat
  private let fraction: CGFloat
  private let order: CGFloat
  
  var animatableData: CGFloat {
    get { percentage }
    set { percentage = newValue }
  }
  
  var size: CGFloat {
    guard percentage != 0 && percentage != 1 else { return 1.0 }
    let isInRange = percentage >= order * fraction && percentage <= order * fraction + fraction
    return isInRange ? 2.0 : 1.0
  }
  
  init(isAnimating: Bool, fraction: CGFloat, order: Int) {
    self.percentage = isAnimating ? 1.0 : 0.0
    self.fraction = fraction
    self.order = CGFloat(order)
  }
  
  func body(content: Content) -> some View {
    content
      .scaleEffect(x: size, y: size)
  }
}
