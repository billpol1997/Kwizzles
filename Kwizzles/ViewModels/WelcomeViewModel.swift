//
//  WelcomeViewModel.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 9/11/22.
//

import Foundation

public final class WelcomeViewModel: ObservableObject{
    @Published var isLoading : Bool = false
    @Published var isLinkActive : Bool = false
    
    
    func fakeNetworkCall(){
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.isLoading = false
            self.isLinkActive = true
        }
    }
    
    
    
}
