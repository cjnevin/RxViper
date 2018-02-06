import Foundation
import RxSwift

protocol DismissModalNavigating {
    func dismiss() -> Completable
}

extension Navigator where Self: DismissModalNavigating {
    func dismiss() -> Completable {
        return self.dismiss(with: ModalNavigation(), animated: true)
    }
}
