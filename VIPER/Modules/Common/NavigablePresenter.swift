import Foundation

class NavigablePresenter<T, U>: Presenter<T> {
    typealias Navigator = U
    var navigator: Navigator?
    
    func attachNavigator(_ navigator: Navigator) {
        assert(self.navigator == nil)
        self.navigator = navigator
    }
    
    func detachNavigator() {
        self.navigator = nil
    }
}
