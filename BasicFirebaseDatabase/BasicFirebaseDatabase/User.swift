import Foundation

struct User: Hashable {
    var userId: String
    var username: String
    var firstName: String
    var lastName: String
    
    init(userId: String, username: String, firstName: String, lastName: String) {
        self.userId = userId
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
    }
}
