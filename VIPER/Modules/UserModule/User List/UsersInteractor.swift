import Foundation

class UsersInteractor {
    private let dataStore: UserDataStore
    
    init(dataStore: UserDataStore) {
        self.dataStore = dataStore
    }
    
    func get() -> [User] {
        return dataStore.users.map { $0.asUser() }
    }
}
