//
//  ScaleableText.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 9/11/22.
//

import SwiftUI

struct ScaleableText: View {
  @Binding var isAnimating: Bool
  let text: String
  let cycle: Bool
  
  private var words: [String] {
    text.map { String($0) }
  }
  private var fraction: CGFloat {
    return 1.0 / CGFloat(words.count)
  }
  
  init(_ text: String, cycle: Bool = false, isAnimating: Binding<Bool>) {
    self.text = text
    self.cycle = cycle
    self._isAnimating = isAnimating
  }
  
  var body: some View {
    HStack(spacing: 0.0) {
      ForEach(words.indices, id: \.self) { index in
        Text(words[index])
          .modifier(FontScaleModifier(isAnimating: isAnimating,
                                      fraction: fraction, order: index))
          .animation(cycle ?
                      isAnimating ?
                              .easeOut(duration: 1.0).repeatForever(autoreverses: false) :
                              .linear(duration: 0)
                      : .linear(duration: 1.0)
          )
      }
    }
  }
}
