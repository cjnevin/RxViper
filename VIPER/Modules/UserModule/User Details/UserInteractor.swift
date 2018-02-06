import Foundation
import RxSwift

enum UserError: Swift.Error {
    case userDoesNotExist
}

class UserInteractor {
    private let dataStore: UserDataStore
    private let current = Variable<User?>(nil)
    
    init(dataStore: UserDataStore) {
        self.dataStore = dataStore
    }
    
    func randomUser() -> User {
        return dataStore.randomUser().asUser()
    }
    
    func observeUser() -> Observable<User> {
        return current.asObservable().filterNil()
    }
    
    func setUser(_ user: User) -> Completable {
        current.value = user
        return .empty()
    }
    
    func setUserId(_ id: Int) -> Completable {
        guard let user = dataStore.user(with: id) else {
            return .error(UserError.userDoesNotExist)
        }
        return self.setUser(user.asUser())
    }
}

