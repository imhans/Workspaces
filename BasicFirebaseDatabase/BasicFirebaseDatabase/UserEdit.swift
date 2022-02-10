
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
        
        NavigationView {
            
            VStack(alignment: .leading) {
                Text("Username")
                    .font(.headline)
                TextField("Edit Your User Name", text: bindingUsername)
                    .font(.subheadline)
                Text("First Name")
                    .font(.headline)
                TextField("Edit Your First Name", text: bindingFirstname)
                    .font(.subheadline)
                Text("Last Name")
                    .font(.headline)
                TextField("Edit Your Last Name", text: bindingLastname)
                    .font(.subheadline)
                    
            }
//            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
        
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
