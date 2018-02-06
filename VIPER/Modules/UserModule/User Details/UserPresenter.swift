import Foundation
import RxSwift
import Action

protocol UserView: TitlableView, Viewable {
    func setFirstName(_ firstName: String)
    func setLastName(_ lastName: String)
    
    func setShowLocationTitle(_ title: String)
    func setShowLocationAction(_ action: CocoaAction)
}


class UserPresenter<T: UserView, U: UserLocationNavigating>: NavigablePresenter<T, U> {
    private let interactor: UserInteractor
    private let userId: Int
    
    init(interactor: UserInteractor,
         userId: Int) {
        self.interactor = interactor
        self.userId = userId
    }
    
    override func attachView(_ view: T) {
        super.attachView(view)
        
        disposeOnViewDetach(interactor.setUserId(userId).subscribe())
        
        disposeOnViewDetach(interactor.observeUser()
            .subscribe(onNext: { user in
                view.setFirstName(user.firstName)
                view.setLastName(user.lastName)
                view.setTitle("\(user.firstName) \(user.lastName)")
            }))
        
        view.setShowLocationTitle("Show Location")
        view.setShowLocationAction(CocoaAction { [weak self] _ in
            guard let `self` = self, let navigator = self.navigator else { return .empty() }
            return navigator.presentUserLocation(with: self.userId).asObservable().map { _ in () }
        })
    }
}
