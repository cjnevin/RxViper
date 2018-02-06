import Foundation
import RxSwift

protocol UserNavigating {
    func presentUser(with userId: Int) -> Completable
}

extension Navigator where Self: UserNavigating, Self: DismissModalNavigating, Self: UserLocationNavigating, Self: UserViewControllerProviderHaving {
    func presentUser(with userId: Int) -> Completable {
        let view: UserViewController<Self> = userViewControllerProvider.provideUserViewController(forUserId: userId)
        view.presenter?.attachNavigator(self)
        
        return present(
            view: view,
            with: PushNavigation(),
            animated: true)
    }
}

protocol UserLocationNavigating {
    func presentUserLocation(with userId: Int) -> Completable
}

extension Navigator where Self: UserLocationNavigating, Self: DismissModalNavigating, Self: UserLocationViewControllerProviderHaving {
    func presentUserLocation(with userId: Int) -> Completable {
        let view: UserLocationViewController<Self> = userLocationViewControllerProvider.provideUserLocationViewController(forUserId: userId)
        view.presenter?.attachNavigator(self)
        
        let navigationController = UINavigationController(rootViewController: view)
        
        return present(view: navigationController,
                       with: ModalNavigation(),
                       animated: true)
    }
}
