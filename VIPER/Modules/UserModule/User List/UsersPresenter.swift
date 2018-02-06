import Foundation
import RxSwift

protocol UsersView: TitlableView, Viewable {
    var selectedUser: PublishSubject<User> { get }
    
    func showUsers(_ users: [User])
}

class UsersPresenter<T: UsersView, U: UserNavigating>: NavigablePresenter<T, U> {
    private let interactor: UsersInteractor
    
    init(interactor: UsersInteractor) {
        self.interactor = interactor
    }
    
    override func attachView(_ newView: T) {
        super.attachView(newView)
        
        newView.setTitle("Users")
        newView.showUsers(interactor.get())
        
        disposeOnViewDetach(newView.selectedUser.asObservable().flatMap { [weak self] (user) -> Completable in
            return self?.navigator?.presentUser(with: user.id) ?? .empty()
        }.subscribe())
    }
}
