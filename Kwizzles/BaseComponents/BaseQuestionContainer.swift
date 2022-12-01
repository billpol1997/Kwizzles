//
//  BaseQuestionContainer.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 10/11/22.
//

import SwiftUI

struct BaseQuestionContainer: View {
    @State var isAnswer: Bool
    var text: String
    var level: String?
    @State var isPressed: Bool = false
    @State var isCorrect: Bool?
    @State var colorBoarder : Color?
    @State var action : () -> Void
    
    init(isAnswer: Bool, text: String, level: String? = nil ,isCorrect: Bool? = nil,colorBoarder: Color? = nil, action: @escaping () -> Void) {
        self.isAnswer = isAnswer
        self.text = text
        self.level = level
        self.isCorrect = isCorrect
        self.colorBoarder = colorBoarder
        self.action = action
    }
    
    var body: some View {
        container
    }
    
    @ViewBuilder
    var container: some View{
        if isAnswer{
            answer
        }else{
            question
        }
    }
    
    var question: some View{
        VStack(alignment: .center){
            Text(level ?? "")
                .customFont(.chalkBold, .mediumFont)
                .foregroundStyle(LinearGradient(colors: [Color.theme.FadeGrey,.purple,Color.theme.FadePurple], startPoint: .leading, endPoint: .trailing))
            Text(text)
                .customFont(.arial, .mediumMaxFont)
                .foregroundColor(.white)
                .customPadding(.top, .questionContainerMiddlePadding)
            Spacer()
                
        }
        .customPadding(.vertical, .questionContainerVerticalPadding)
        .customPadding(.horizontal, .questionContainerHorizontalPadding)
        .frame(width: CGFloat(.questionWidth),height: CGFloat(.questionHeight),alignment: .center)
        .background(RoundedRectangle(cornerRadius: CGFloat(.questionRadius)).fill(Color.theme.BrightBrown))
        .overlay(RoundedRectangle(cornerRadius: CGFloat(.questionRadius))
            .stroke(Color.theme.BoarderBrown,lineWidth: 4))
    }
    
    var answer: some View{
        Button{
            isPressed = true
            action()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                isPressed = false
            }
        }label: {
            HStack{
                Text(text)
                    .customFont(.arial, .smallFont)
                    .foregroundColor(.white)
                    .frame(width: CGFloat(.answerWidth),height: CGFloat(.answerHeight),alignment: .center)
                    .background(RoundedRectangle(cornerRadius: CGFloat(.answerRadius)).fill(Color.theme.FadePurple))
                    .overlay(RoundedRectangle(cornerRadius: CGFloat(.answerRadius))
                        .stroke(isPressed ? isCorrect ?? false ? .green : .red : .clear,lineWidth: 2))
            }
        }
    }
}

