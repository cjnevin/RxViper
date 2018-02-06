import Foundation
import RxSwift
import Action

struct Alert {
    struct Option {
        enum Style {
            case cancel
            case destructive
            case `default`
        }
        let title: String
        let style: Style
        let action: Action<String, Void>
    }
    enum Style {
        case alert
        case actionSheet
    }
    
    let title: String
    let message: String
    let style: Style
    let options: [Option]
}

protocol AlertableView {
    func dismissAlert() -> Completable
    func presentAlert(_ alert: Alert) -> Completable
}

private extension Alert.Style {
    func asUIAlertControllerStyle() -> UIAlertControllerStyle {
        switch self {
        case .alert: return .alert
        case .actionSheet: return .actionSheet
        }
    }
}

private extension Alert.Option.Style {
    func asUIAlertActionStyle() -> UIAlertActionStyle {
        switch self {
        case .cancel: return .cancel
        case .default: return .default
        case .destructive: return .destructive
        }
    }
}

private extension Alert.Option {
    func asUIAlertAction() -> UIAlertAction {
        return UIAlertAction(title: title, style: style.asUIAlertActionStyle()) { (alertAction) in
            self.action.execute(self.title)
        }
    }
}

private extension Alert {
    func asUIAlertController() -> UIAlertController {
        let controller = UIAlertController(title: title, message: message, preferredStyle: style.asUIAlertControllerStyle())
        options.forEach { controller.addAction($0.asUIAlertAction()) }
        return controller
    }
}

extension AlertableView where Self: UIViewController {
    func dismissAlert() -> Completable {
        return Completable.create { (observer) in
            self.dismiss(animated: true) {
                observer(.completed)
            }
            return Disposables.create()
        }
    }
    
    func presentAlert(_ alert: Alert) -> Completable {
        return Completable.create { (observer) in
            self.present(alert.asUIAlertController(), animated: true) {
                observer(.completed)
            }
            return Disposables.create()
        }
    }
}
