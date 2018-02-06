import Foundation
import RxSwift
import RxOptional

protocol UserDataStoreHaving {
    var userDataStore: UserDataStore { get }
}

protocol UserDataStore {
    var users: [UserDTO] { get }
    
    func user(with id: Int) -> UserDTO?
    func randomUser() -> UserDTO
}

class UserMemoryDataStore: UserDataStore {
    let users: [UserDTO] = {
        return [
            UserDTO(id: 1, firstName: "Kate", lastName: "Winslet"),
            UserDTO(id: 2, firstName: "Hugh", lastName: "Jackman"),
            UserDTO(id: 3, firstName: "Nicole", lastName: "Kidman"),
            UserDTO(id: 4, firstName: "David", lastName: "Attenborough"),
            UserDTO(id: 5, firstName: "Johnny", lastName: "Depp"),
            UserDTO(id: 6, firstName: "Jim", lastName: "Carrey")
        ]
    }()
    
    func user(with id: Int) -> UserDTO? {
        return users.first(where: { $0.id == id })
    }
    
    func randomUser() -> UserDTO {
        let index = Int(arc4random_uniform(UInt32(users.count)))
        return users[index]
    }
}
