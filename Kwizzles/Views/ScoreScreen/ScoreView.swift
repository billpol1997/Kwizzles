//
//  ScoreView.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 10/11/22.
//

import SwiftUI

struct ScoreView: View {
    @State var isAnimating : Bool = false
    @ObservedObject var manager : GameManagerVM
    var body: some View {
        ZStack{
            Image(.KwizzlesBackground)
                .resizable()
                .edgesIgnoringSafeArea(.all)
            scoreView
        }
    }
    
    var scoreView: some View{
        VStack{
            score
            playAgain
        }
        .customPadding(.vertical, .gameVerticalPadding)
    }
    
    var score: some View{
        VStack{
            Spacer()
            Text(.gameOver)
                .customFont(.chalkBold, .hugeFont)
                .foregroundColor(Color.theme.BrightBrown)
            Spacer()
            Text(.score)
                .customFont(.chalkBold, .bigFont)
                .foregroundColor(Color.theme.BrightBrown)
            ScaleableText(String(manager.totalPoints),isAnimating: $isAnimating)
                .customFont(.chalkBold, .hugeFont)
                .foregroundColor(Color.theme.BrightBrown)
            Spacer()
        }
        .onAppear{
            isAnimating = true
        }
    }
    
    var playAgain: some View{
        VStack{
            Spacer()
            playAgainButton
        }
    }
    
    var playAgainButton: some View{
        Button{
            manager.restartGame()
        }label: {
            Text(.playAgain)
                .customFont(.chalk, .bigFont)
                .foregroundColor(Color.theme.FadeGrey)
                .customPadding(.bottom, .playButtonInnerBottomPadding)
                .frame(width: CGFloat(.playButtonWidth),height: CGFloat(.playButtonHeight),alignment: .center)
                .background(Color.theme.DeepPurple)
                .overlay(
                    RoundedRectangle(cornerRadius: CGFloat(.playButtonRadius))
                        .stroke(Color.theme.BoarderBrown,lineWidth: 2)
                )
        }
    }
}



struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(manager: GameManagerVM())
    }
}
