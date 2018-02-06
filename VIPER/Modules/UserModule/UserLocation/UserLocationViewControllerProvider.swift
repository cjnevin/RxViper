import Foundation

protocol UserLocationViewControllerProviding {
    func provideUserLocationViewController<T: DismissModalNavigating>(forUserId userId: Int) -> UserLocationViewController<T>
}

protocol UserLocationViewControllerProviderHaving {
    var userLocationViewControllerProvider: UserLocationViewControllerProvider { get }
}

struct UserLocationViewControllerProvider: UserLocationViewControllerProviding, UserDataStoreHaving, UserLocationDataStoreHaving {
    let userDataStore: UserDataStore
    let userLocationDataStore: UserLocationDataStore
    
    func provideUserLocationViewController<T: DismissModalNavigating>(forUserId userId: Int) -> UserLocationViewController<T> {
        let viewController = UserLocationViewController<T>()
        let interactor = UserLocationInteractor(userDataStore: userDataStore, userLocationDataStore: userLocationDataStore)
        let presenter = UserLocationPresenter<UserLocationViewController<T>, T>(interactor: interactor, userId: userId)
        viewController.presenter = presenter
        return viewController
    }
}
