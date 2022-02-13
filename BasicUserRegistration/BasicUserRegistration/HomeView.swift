//
//  HomeView.swift
//  BasicUserRegistration
//
//  Created by Hans Yim on 2022/02/13.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack {
                customUserBar
                
                HStack {
                    Text("Welcome!")
                        .font(.largeTitle)
                    Spacer()
                }
                .padding()
            }
        }
        
    }
    
    private var customUserBar: some View {
        
        HStack {
            Image(systemName: "person.crop.circle")
                .font(.system(size: 60))
                .foregroundColor(.blue)
                .padding()
            VStack(alignment: .leading, spacing: 4) {
                Text("First Last")
                    .foregroundColor(.blue)
                    .font(.headline)
                Text("email@e.e")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                HStack(alignment: .center) {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 12, height: 12)
                    Text("online")
                        .font(.footnote)
                        .foregroundColor(.green)
                }
            }
            Spacer()
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
