import Foundation
import Action

protocol ClosableView: class {
    var closeBarButtonItem: UIBarButtonItem? { get set }
    func setCloseAction(_ action: CocoaAction)
    func setCloseTitle(_ title: String)
}

private struct AssociatedKeys {
    static var closeBarButtonItem = "closableView_closeBarButtonItem"
}

extension ClosableView where Self: UIViewController {
    var closeBarButtonItem: UIBarButtonItem? {
        get {
            guard let closeButton = objc_getAssociatedObject(self, &AssociatedKeys.closeBarButtonItem) as? UIBarButtonItem else {
                let newBarButtonItem = UIBarButtonItem()
                navigationItem.leftBarButtonItem = newBarButtonItem
                closeBarButtonItem = newBarButtonItem
                return newBarButtonItem
            }
            return closeButton
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.closeBarButtonItem, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func setCloseAction(_ action: CocoaAction) {
        closeBarButtonItem?.rx.action = action
    }
    
    func setCloseTitle(_ title: String) {
        closeBarButtonItem?.title = title
    }
}
