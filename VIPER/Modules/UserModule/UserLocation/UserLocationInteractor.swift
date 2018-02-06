import Foundation
import RxSwift

class UserLocationInteractor {
    private let userDataStore: UserDataStore
    private let userLocationDataStore: UserLocationDataStore
    
    init(userDataStore: UserDataStore,
         userLocationDataStore: UserLocationDataStore) {
        self.userDataStore = userDataStore
        self.userLocationDataStore = userLocationDataStore
    }
    
    func user(with id: Int) -> User? {
        return userDataStore.user(with: id)?.asUser()
    }
    
    func location(with id: Int) -> UserLocation? {
        return userLocationDataStore.userLocation(with: id)?.asUserLocation()
    }
}
