import Foundation
import RxSwift
import RxTest
import RxBlocking
import XCTest
@testable import VIPER

class NavigatorMock: Navigator {
    let viewablesMock = Mock([Viewable]())
    var viewables: [Viewable] {
        return viewablesMock.execute()
    }
    
    let dismissMock = Mock(Completable.empty())
    func dismiss(with mode: NavigationMode, animated: Bool) -> Completable {
        viewablesMock.set(Array(viewablesMock.value.dropLast()))
        return dismissMock.execute()
    }
    
    let presentMock = Mock(Completable.empty())
    func present(view: Viewable, with mode: NavigationMode, animated: Bool) -> Completable {
        viewablesMock.set(viewablesMock.value + [view])
        return presentMock.execute()
    }
}

class ViewableMock: Viewable { }
