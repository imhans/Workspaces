//
//  SignInView.swift
//  BasicUserRegistration
//
//  Created by Hans Yim on 2022/02/13.
//

import SwiftUI

struct SignInView: View {
    @State private var isSignInMode = true
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                Picker(selection: $isSignInMode, label: Text("SignIn or SignUp")) {
                    Text("Sign In").tag(true)
                    Text("Sign Up").tag(false)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.bottom)
                
                if (isSignInMode) { // SignInMode True
                    Group (content: {
                        TextField("Email Address", text: $email)
                        TextField("Password", text: $password)
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.subheadline)
                    .padding(.bottom, 4)
                    
                    Button(action: {
                        SignInUser()
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Sign In")
                                .font(.headline)
                                .padding(.vertical, 10)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .background(Color.blue)
                        .cornerRadius(8)
                    })
                        .padding(.bottom)
                    
                    Group (content: { // Sign Ip Error Messages
                        
                    })
                   
                } else { // SignUp Mode: SignInMode False
                    Group (content: {
                        TextField("Firstname", text: $firstname)
                        TextField("Lastname", text: $lastname)
                        TextField("Email Address", text: $email)
                        TextField("Password", text: $password)
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.subheadline)
                    .padding(.bottom, 4)
                    
                    Button(action: {
                        SignInUser()
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Sign Up")
                                .font(.headline)
                                .padding(.vertical, 10)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .background(Color.blue)
                        .cornerRadius(8)
                    })
                        .padding(.bottom)
                    
                    Group (content: { // Sign Up Error Messages
                        
                    })
                    
                }
            }
            .padding()
            
        }
        
        
    }
}

private func SignInUser() {
    
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
