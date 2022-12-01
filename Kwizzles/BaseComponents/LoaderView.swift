//
//  LoaderView.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 9/11/22.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        ZStack{
            Image(.KwizzlesBackground)
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack(){
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint:(Color.theme.BrightBrown)))
                    .scaleEffect(2)
            }
                
            
        }
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
