import Foundation
import UIKit

extension UsersNavigator {
    static func make() -> UsersNavigator {
        let userDataStore = UserMemoryDataStore()
        let userLocationDataStore = UserLocationMemoryDataStore()
        
        let usersViewControllerProvider = UsersViewControllerProvider(userDataStore: userDataStore)
        let userViewControllerProvider = UserViewControllerProvider(userDataStore: userDataStore)
        let userLocationControllerProvider = UserLocationViewControllerProvider(userDataStore: userDataStore, userLocationDataStore: userLocationDataStore)
        
        let navigator = UsersNavigator(usersViewControllerProvider: usersViewControllerProvider,
                                       userViewControllerProvider: userViewControllerProvider,
                                       userLocationViewControllerProvider: userLocationControllerProvider)
        
        return navigator
    }
}

class UsersNavigator: UINavigationController, DismissModalNavigating, UserNavigating, UsersViewControllerProviderHaving, UserViewControllerProviderHaving, UserLocationNavigating, UserLocationViewControllerProviderHaving {
    let usersViewControllerProvider: UsersViewControllerProvider
    let userViewControllerProvider: UserViewControllerProvider
    let userLocationViewControllerProvider: UserLocationViewControllerProvider
    
    private init(usersViewControllerProvider: UsersViewControllerProvider,
         userViewControllerProvider: UserViewControllerProvider,
         userLocationViewControllerProvider: UserLocationViewControllerProvider) {
        self.usersViewControllerProvider = usersViewControllerProvider
        self.userViewControllerProvider = userViewControllerProvider
        self.userLocationViewControllerProvider = userLocationViewControllerProvider
        let usersViewController: UsersViewController<UsersNavigator> = usersViewControllerProvider.provideUsersViewController()
        super.init(nibName: nil, bundle: nil)
        usersViewController.presenter?.attachNavigator(self)
        setViewControllers([usersViewController], animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
