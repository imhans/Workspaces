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
    var databaseHandle: DatabaseHandle?
    
    @State private var username: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var showingAlert = false
    
    @State var userData = [User]()
    
    init() {
        //self.fetchUserData()
    }
    var body: some View {
        
        VStack(alignment: .leading) {
            
            // Create Part
            HStack {
                Text("Add an User")
                    .font(.headline)
                Spacer()
                Button("+Add", action: {addNewUser()})
                    .alert(isPresented: $showingAlert) {
                        return Alert(title: Text("Error"), message: Text("Enter your user information"), dismissButton: .default(Text("Dismiss")))
                    }
            }
            
            HStack {
                TextField("User name", text: $username)
                Spacer()
                TextField("First Name", text: $firstName)
                Spacer()
                TextField("Last Name", text: $lastName)
            }
            .font(.subheadline)
            .padding(.bottom)
            
            
            // Read Part
            Text("Users")
                .font(.headline)
            List {
                ForEach(self.userData, id:\.self) { user in
                    HStack {
                        // username
                        Image(systemName: "heart.fill")
                        .foregroundColor(.blue)
                    
                        // first and last name
                        Text(user.username)
                            .font(.headline)
                        Spacer()
                        Text(user.firstName)
                        Text(user.lastName)
                    }
                }
                // Delete Part
                .onDelete(perform: { indextSet in
                    // SwiftUI passes a set of indices to the closure that's relative to the dynamic view's underlying collection of data
                    // Map user data with the given indices
                    let userId = indextSet.map {
                        self.userData[$0].userId
                    }
                    // print(userId[0].self)
                    ref.child("Users").child(userId[0].self).removeValue()
                })
            }
            .onAppear {
                self.fetchUserData()    //getData
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
            
            // Clear text fields
            self.$username.wrappedValue = "";
            self.$firstName.wrappedValue = "";
            self.$lastName.wrappedValue = "";
            
        } else {
            self.showingAlert = true;
        }
    }
    
    func fetchUserData() {
        ref.child("Users").observe(.value) { snapshot in
            
            var newUsers = [User]()
            
            for child in snapshot.children {
                let userSnap = child as! DataSnapshot
                let userId = userSnap.key
                let userDict = userSnap.value as! [String: AnyObject]
                let username = userDict["username"] as! String
                let firstName = userDict["firstName"] as! String
                let lastName = userDict["lastName"] as! String
                
                let user = User(userId: userId, username: username, firstName: firstName, lastName: lastName)
                newUsers.append(user as User)
            }
            
            self.userData = newUsers
        }
        
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
