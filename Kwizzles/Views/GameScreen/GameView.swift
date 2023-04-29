//
//  GameView.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 10/11/22.
//

import SwiftUI

struct GameView: View {
    
    @ObservedObject var manager : GameViewModel
    @State var soundState: Bool = true
    var sound = SoundManager()
    
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
                .customPadding(.bottom, .timerVerticalPadding)
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
                .animation(Animation.linear(duration: Double(manager.maxProgress)), value: manager.isEndOfCounter() ? 0 : manager.progress)
            
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
          soundButton
            Spacer()
            VStack(alignment: .trailing , spacing:1){
              questionIndex
              points
            }
        }
        .customPadding(.horizontal, .gameHorizontalPadding)
    }
    
    var soundButton: some View {
        Button {
            soundState.toggle()
        } label: {
            ZStack{
                Circle()
                    .fill(soundState ? Color.theme.FadePurple : Color.theme.BrightBrown)
                    .frame(width: 40, height: 40)
                Image(soundState ? .soundON : .soundOFF)
                    .resizable()
                    .frame(width: 25, height: 25)
            }
           
        }
        .onAppear{
            sound.playSound(sound: .backgroundMusic, val: true)
        }
    }
    
    var questionIndex: some View {
        HStack{
            Text(String(GameViewModel.currentIndex))
            Text("/")
            Text(String(GameViewModel.maxIndex))
        }
        .customFont(.chalkBold, .smallFont)
        .foregroundColor(Color.theme.FadeGrey)
    }
    
    var points: some View {
        HStack{
            Text(String(manager.totalPoints))
            Text("pts")
        }
        .customFont(.chalkBold, .smallFont)
        .foregroundColor(Color.theme.BrightWhite)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView( manager: GameViewModel())
    }
}
