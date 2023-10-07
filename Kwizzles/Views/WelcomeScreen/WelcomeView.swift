//
//  WelcomeView.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 9/11/22.
//

import SwiftUI

struct WelcomeView: View {
    @State var isPressAnimated : Bool = false
    @State var isTitleAnimated : Bool = false
    @ObservedObject var viewModel = WelcomeViewModel()
    @ObservedObject var manager = GameViewModel()
    var body: some View {
        ZStack{
            Image(.KwizzlesBackground)
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack{
                title
                slogan
                pressPlay
                
            }
            loader
        }
    }
    
    var title : some View{
        VStack(spacing: 0){
            ScaleableText("Kwizzles", cycle: false,isAnimating: $isTitleAnimated)
                .customFont(.chalkBold, .maxFont)
                .foregroundColor(Color.theme.BrightBrown)
            Image(.KwizzlesLogo)
                .resizable()
                .frame(width: CGFloat(.logoWidth),height: CGFloat(.logoHeight))
            Spacer()
        }
        .onAppear{
            isTitleAnimated = true
        }
    }
    
    var slogan: some View{
        HStack {
            Text(.slogan)
                .customFont(.chalkBold, .mediumFont)
                    .foregroundColor(Color.theme.FadeGrey)
        }
    }
    
    var pressPlay: some View{
        VStack{
            HStack{
                ScaleableText("Press Play to Start", cycle: false,isAnimating: $isPressAnimated)
                    .customFont(.impact, .mediumMaxFont)
                    .foregroundColor(Color.theme.BrightWhite)
            }
            .customPadding(.vertical, .welcomeScreenTextsPaddingAlt)
            playButton
            
        }
        .customPadding(.vertical, .welcomeScreenTextsPadding)
        .onAppear{
            isPressAnimated.toggle()
        }
    }
    
    var playButton: some View{
        Button{
            viewModel.fakeNetworkCall()
            manager.startTimer()
        }label: {
            Text(.play)
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
        .navigationDestination(isPresented: $viewModel.isLinkActive){
            GameView(manager : manager)
        }
    }
    
    @ViewBuilder
    var loader : some View{
        if viewModel.isLoading{
            LoaderView()
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
