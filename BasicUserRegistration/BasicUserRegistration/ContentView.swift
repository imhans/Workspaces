//
//  ContentView.swift
//  BasicUserRegistration
//
//  Created by Hans Yim on 2022/02/12.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isUserSignedIn = false
   
    var body: some View {
        if (isUserSignedIn) {
            HomeView()
        } else {
            SignInView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
