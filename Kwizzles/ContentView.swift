//
//  ContentView.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 9/11/22.
//

import SwiftUI

struct ContentView: View {
    var welcome = WelcomeView()
    var body: some View {
         navStack
    }
    
    var navStack: some View{
        NavigationStack{
            welcome
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
