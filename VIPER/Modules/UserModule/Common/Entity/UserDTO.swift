import Foundation

struct UserDTO {
    let id: Int
    let firstName: String
    let lastName: String
    
    func asUser() -> User {
        return User(id: id, firstName: firstName, lastName: lastName)
    }
}
