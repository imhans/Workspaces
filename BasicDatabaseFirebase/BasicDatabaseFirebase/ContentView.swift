//
//  ContentView.swift
//  BasicDatabaseFirebase
//
//  Created by Hans Yim on 2022/02/03.
//

import SwiftUI
import Firebase

struct ContentView: View {
    var ref = DatabaseReference!
    ref = Database.database().reference()

    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
