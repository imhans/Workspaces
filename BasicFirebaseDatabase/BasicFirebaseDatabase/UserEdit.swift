
import SwiftUI
import Firebase

struct UserEdit: View {
    var ref: DatabaseReference! = Database.database(url: "https://basic-firebase-database-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
    
    @State var user: User
    
    var body: some View {
        
        let bindingUsername = Binding<String>(
            get: { $user.username.wrappedValue },
            set: { $user.username.wrappedValue = $0; self.textFieldChanged(text: $0, id: $user.userId.wrappedValue, path: "username") }
        )
        let bindingFirstname = Binding<String>(
            get: { $user.firstName.wrappedValue },
            set: { $user.firstName.wrappedValue = $0; self.textFieldChanged(text: $0, id: $user.userId.wrappedValue, path: "firstName") }
        )
        let bindingLastname = Binding<String>(
            get: { $user.lastName.wrappedValue },
            set: { $user.lastName.wrappedValue = $0; self.textFieldChanged(text: $0, id: $user.userId.wrappedValue, path: "lastName") }
        )
         
        VStack(alignment: .leading) {
            Form {
                Section(header: Text("Username")) {
                    TextField("Edit Your User Name", text: bindingUsername)
                }
                Section(header: Text("Firstname")) {
                    TextField("Edit Your First Name", text: bindingFirstname)
                }
                Section(header: Text("Lastname")) {
                    TextField("Edit Your Last Name", text: bindingLastname)
                }
            }
        }
    }
    private func textFieldChanged(text: String, id: String, path: String) {
        ref.child("Users").child(id).child(path).setValue(text)
        //print(text)
        print("User data successfully updated")
    }
}

struct UserEdit_Previews: PreviewProvider {
    static let sample = User(userId: "dd", username: "dd", firstName: "dd", lastName: "dd")
    static var previews: some View {
        UserEdit(user: sample)
    }
}
