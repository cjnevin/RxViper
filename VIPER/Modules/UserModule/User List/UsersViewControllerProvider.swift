import Foundation

protocol UsersViewControllerProviding {
    func provideUsersViewController<T: UserLocationNavigating>() -> UsersViewController<T>
}

protocol UsersViewControllerProviderHaving {
    var usersViewControllerProvider: UsersViewControllerProvider { get }
}

struct UsersViewControllerProvider: UsersViewControllerProviding, UserDataStoreHaving {
    let userDataStore: UserDataStore
    
    func provideUsersViewController<T: UserLocationNavigating>() -> UsersViewController<T> {
        let viewController = UsersViewController<T>()
        let interactor = UsersInteractor(dataStore: userDataStore)
        let presenter = UsersPresenter<UsersViewController<T>, T>(interactor: interactor)
        viewController.presenter = presenter
        return viewController
    }
}

