//
//  GameView.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 10/11/22.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var manager : GameManagerVM
    var body: some View {
        ZStack{
            Image(.KwizzlesBackground)
                .resizable()
                .edgesIgnoringSafeArea(.all)
            if(manager.model.quizCompleted){
                ScoreView(manager: manager)
            }else{
                gameContent
            }
        }
        .navigationBarHidden(true)
    }
    
    var gameContent: some View{
        VStack{
            toolbar
            Spacer()
            timer
            Spacer()
            QuestionsGridView(manager: manager)
        }
        .customPadding(.horizontal, .gameHorizontalPadding)
        .customPadding(.vertical, .gameVerticalPadding)
    }
    
    var timer : some View{
        ZStack{
            Circle()
                .stroke(lineWidth: 2)
                .foregroundColor(.gray)
                .opacity(0.7)
            
            Circle()
                .trim(from: 0.0, to: min(CGFloat((Double(manager.progress) * Double(manager.maxProgress))/100),1.0))
                .stroke(LinearGradient(colors: [Color.theme.BrightBrown, Color.theme.BrightWhite], startPoint: .topLeading, endPoint: .bottomTrailing),
                        style: StrokeStyle(lineWidth: 9,lineCap: .round,lineJoin: .round))
                .rotationEffect(Angle(degrees: 270))
                .animation(Animation.linear(duration: Double(manager.maxProgress)), value: manager.progress)
            
            Text(String(manager.progress))
                .customFont(.chalkBold, .mediumFont)
                .foregroundColor(Color.theme.BrightWhite)
                .opacity(0.9)
        }
        .frame(width: CGFloat(.timerWidth),height: CGFloat(.timerHeight))
    }
    
    var time: some View{
        HStack{
            Spacer()
            timer
        }
    }
    
    var toolbar: some View{
        HStack{
            Group{
                Text(String(manager.totalPoints))
                Text("pts")
            }
            .customFont(.chalkBold, .smallFont)
            .foregroundColor(Color.theme.BrightWhite)
            Spacer()
            Group{
                Text(String(GameManagerVM.currentIndex))
                Text("/")
                Text(String(GameManagerVM.maxIndex))
            }
            .customFont(.chalkBold, .smallFont)
            .foregroundColor(Color.theme.FadeGrey)
        }
        .customPadding(.horizontal, .gameHorizontalPadding)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView( manager: GameManagerVM())
    }
}
