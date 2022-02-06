//
//  ContentView.swift
//  BasicFirebaseDatabase
//
//  Created by Hans Yim on 2022/02/06.
//

import SwiftUI
import Firebase

struct ContentView: View {
    var ref: DatabaseReference! = Database.database(url: "https://basic-firebase-database-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
    
    @State private var username: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var showingAlert = false
    
    //var userData: [String]
//    ref.child("Users").observeSingleEvent(of: .value) { (snapshot) in
//    self.userData.append(snapshot.value as? [String: Any])
//    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            // Create Part
            HStack {
                Text("Add an User")
                    .font(.headline)
                Spacer()
                Button("+Add", action: {addNewUser()})
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error"), message: Text("Enter your user information"), dismissButton: .default(Text("Dismiss")))
                }
            }
            HStack {
                TextField("Username", text: $username)
                Spacer()
                TextField("First Name", text: $firstName)
                Spacer()
                TextField("Last Name", text: $lastName)
            }
            .padding(.bottom)
            
            // Read Part
            Text("Users")
                .font(.headline)
            
            List {
                Text("User 1")
                Text("User 2")
            }
            
            
        }
        .padding()
    }
    
    /* Create */
    func addNewUser() {
        if ($username.wrappedValue != "" && $lastName.wrappedValue != "" && $firstName.wrappedValue != "") {
            let newUser: [String: Any] = [
                "username": $username.wrappedValue,
                "firstName": $firstName.wrappedValue,
                "lastName": $lastName.wrappedValue
            ]
            ref.child("Users").childByAutoId().setValue(newUser)
        } else {
            self.showingAlert = true;
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
