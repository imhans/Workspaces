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
    
    @State private var showPasswordCheck: Bool = false
    @State private var pwdLength: Int = 0
    
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
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
//                            .disableAutocorrection(true)
                        SecureField("Password", text: $password)
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
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        SecureField("Password", text: $password)
                            // Catch the text changes and call checkStrengthPwd() to display password check results
                            .onChange(of: $password.wrappedValue, perform: { value in
                                if $password.wrappedValue.count == 1 {
                                    showPasswordCheck = true
                                } else if ($password.wrappedValue.count == 0) {
                                    showPasswordCheck = false
                                }
                            })
                        
                        HStack {
                            if showPasswordCheck {
                                if checkStrengthPwd(pwd: $password.wrappedValue) == 0 {
                                    Image(systemName: "minus.rectangle.portrait.fill")
                                        .foregroundColor(.red)
                                    Text("Password weak")
                                        .foregroundColor(.red)
                                        .font(.system(size: 10))
                                } else {
                                    Image(systemName: "checkmark.shield.fill")
                                        .foregroundColor(.green)
                                    Text("Password strong")
                                        .foregroundColor(.green)
                                        .font(.system(size: 10))
                                }
                                Spacer()
                            }
                            
                        }
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

private func checkStrengthPwd(pwd: String) -> Int {
    let pwdLength = pwd.count
    var containsSymbol = false
    var containsUppercase = false
    
    for character in pwd {
        if "ABCDEFGHIZKLMNOPQRSTUVWXYZ".contains(character) {
            containsUppercase = true
        }
        if "!@#$%^&*()_+-=".contains(character) {
            containsSymbol = true
        }
    }
    
    if (pwdLength > 8 && containsSymbol && containsUppercase) {
        return 1
    } else {
        return 0
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
