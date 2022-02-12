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
    @State private var editingAlert = false
    
    @State var userDatas = [User]()
    @State var userData: User? = nil
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                // Read Part
                List {
                    ForEach(self.userDatas, id:\.self) { user in
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
                            
                            // Update Part: Navigates to UserEdit page for updating
                            NavigationLink(destination: UserEdit(user: user)) {
                                Spacer()
                                Text("")
                            }
                        }
                    }
                    // Delete Part
                    .onDelete(perform: { indextSet in
                        // SwiftUI passes a set of indices to the closure that's relative to the dynamic view's underlying collection of data
                        // Map user data with the given indices
                        let userId = indextSet.map {
                            self.userDatas[$0].userId
                        }
                        // print(userId[0].self)
                        print("The user successfully got removed from database")
                        ref.child("Users").child(userId[0].self).removeValue()
                    })
                }
                .alert(isPresented: $editingAlert) {
                    Alert(title: Text("Delete"), message: Text("Do you want to remove this user? \n@\(self.userData!.username)"), primaryButton: .default(Text("No")), secondaryButton: .destructive(Text("Yes")))
                }
                .onAppear {
                    self.fetchUserData()    //getData
                }
//                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: 400, alignment: .center)
                
            
                // Create Part
                HStack {
                    Text("Add a User")
                        .font(.headline)
                    Spacer()
                    Button("+Add", action: {addNewUser()})
                        .alert(isPresented: $showingAlert) {
                            return Alert(title: Text("Error"), message: Text("Enter user information"), dismissButton: .default(Text("Dismiss")))
                        }
                }
                .padding(.top)
                .padding(.leading)
                .padding(.trailing)
                
                HStack {
                    TextField("User name", text: $username)
                    Spacer()
                    TextField("First Name", text: $firstName)
                    Spacer()
                    TextField("Last Name", text: $lastName)
                }
                .font(.subheadline)
                .padding()
                
                
            }
            .navigationBarTitle("Users", displayMode: .automatic)
        }
    }
    
    /* Create */
    func addNewUser() {
        if ($username.wrappedValue != "" && $lastName.wrappedValue != "" && $firstName.wrappedValue != "") {
            let newUser: [String: Any] = [
                "username": $username.wrappedValue,
                "firstName": $firstName.wrappedValue,
                "lastName": $lastName.wrappedValue
            ]
            
            print("New user added: @\($username.wrappedValue)")
            ref.child("Users").childByAutoId().setValue(newUser)
            
            // Clear text fields
            self.$username.wrappedValue = "";
            self.$firstName.wrappedValue = "";
            self.$lastName.wrappedValue = "";
            
        } else {
            self.showingAlert = true;
        }
    }
    
    /* Update */
    func updateUser() {
        
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
            
            self.userDatas = newUsers
        }
        
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
