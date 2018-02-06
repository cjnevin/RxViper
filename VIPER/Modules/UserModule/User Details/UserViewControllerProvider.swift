import Foundation

protocol UserViewControllerProviding {
    func provideUserViewController<T: UserLocationNavigating>(forUserId userId: Int) -> UserViewController<T>
}

protocol UserViewControllerProviderHaving {
    var userViewControllerProvider: UserViewControllerProvider { get }
}

struct UserViewControllerProvider: UserViewControllerProviding, UserDataStoreHaving {
    let userDataStore: UserDataStore
    
    func provideUserViewController<T: UserLocationNavigating>(forUserId userId: Int) -> UserViewController<T> {
        let viewController = UserViewController<T>()
        let interactor = UserInteractor(dataStore: userDataStore)
        let presenter = UserPresenter<UserViewController<T>, T>(interactor: interactor, userId: userId)
        viewController.presenter = presenter
        return viewController
    }
}
