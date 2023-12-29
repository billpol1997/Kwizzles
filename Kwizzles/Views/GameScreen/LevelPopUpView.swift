//
//  LevelPopUpView.swift
//  Kwizzles
//
//  Created by Bill on 29/12/23.
//

import SwiftUI

struct LevelPopUpView: View {
    
    var level: String
    var isLevelUp: Bool
    
    var body: some View {
        container
    }
    
    var text: String {
        switch isLevelUp {
        case true:
            return "🤩 You leveled up to \n \(level)!"
        case false:
            return "😢 You leveled down to \n \(level)!"
        }
    }
    
    var boarderColor: LinearGradient {
        switch isLevelUp {
        case true:
            return LinearGradient(colors: [.green,.cyan, .green, .cyan, .green], startPoint: .leading, endPoint: .trailing)
        case false:
            return LinearGradient(colors: [.red, Color.theme.BrightBrown, .red ,.orange, .red, Color.theme.BrightBrown, .red, .orange, .red], startPoint: .leading, endPoint: .trailing)
        }
    }
    
    var container: some View {
        HStack {
            Text(text)
                .customFont(.arial, .tinyFont)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 12)
        .background(RoundedRectangle(cornerRadius: 24).fill(Color.theme.BoarderBrown))
        .overlay(RoundedRectangle(cornerRadius: 24)
            .stroke(boarderColor, lineWidth: 4))
    }
}

#Preview {
    LevelPopUpView(level: "beginner", isLevelUp: false)
}
