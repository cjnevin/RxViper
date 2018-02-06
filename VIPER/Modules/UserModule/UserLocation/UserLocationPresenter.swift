import Foundation
import Action
import RxSwift

protocol UserLocationView: TitlableView, ClosableView, AlertableView, Viewable {
    func setUserLocation(_ userLocation: UserLocation)
}

class UserLocationPresenter<T: UserLocationView, U: DismissModalNavigating>: NavigablePresenter<T, U> {
    private let interactor: UserLocationInteractor
    private let userId: Int
    
    init(interactor: UserLocationInteractor, userId: Int) {
        self.interactor = interactor
        self.userId = userId
    }
    
    override func attachView(_ view: T) {
        super.attachView(view)
        
        let user = interactor.user(with: userId)
        
        if let user = user {
            view.setTitle("\(user.firstName)'s Location")
        } else {
            view.setTitle("Unknown User's Location")
        }
        
        if let location = interactor.location(with: userId) {
            view.setUserLocation(location)
        } else {
            let okAction = Action<String, Void>() { title in
                return view.dismissAlert()
                    .asObservable()
                    .map { _ in () }
            }
            let okOption = Alert.Option(title: "OK", style: .cancel, action: okAction)
            
            let name = user?.firstName ?? "unknown"
            let alert = Alert(title: "No Location", message: "Location for \(name) is unavailable.", style: .alert, options: [okOption])
            
            disposeOnViewDetach(view.presentAlert(alert).subscribe())
        }
        
        let action = CocoaAction { [weak self] _ in
            return self?.navigator?.dismiss().asObservable().map { _ in () } ?? .empty()
        }
        
        view.setCloseAction(action)
        view.setCloseTitle("Close")
    }
}
