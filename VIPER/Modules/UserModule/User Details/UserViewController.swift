import UIKit
import RxSwift
import Action
import SnapKit

class UserViewController<T: UserLocationNavigating>: UIViewController, UserView {
    private lazy var showLocationButton: UIButton = UIButton.makeButton()
    private lazy var firstNameLabel: UILabel = UILabel.makeFirstNameLabel()
    private lazy var lastNameLabel: UILabel = UILabel.makeLastNameLabel()
    
    var presenter: UserPresenter<UserViewController, T>?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        presenter?.attachView(self)
        layout()
    }
    
    deinit {
        presenter?.detachView()
    }
    
    func setShowLocationTitle(_ title: String) {
        showLocationButton.setTitle(title, for: .normal)
    }
    
    func setShowLocationAction(_ action: CocoaAction) {
        showLocationButton.rx.action = action
    }
    
    func setFirstName(_ firstName: String) {
        firstNameLabel.text = "First name: \(firstName)"
    }
    
    func setLastName(_ lastName: String) {
        lastNameLabel.text = "Last name: \(lastName)"
    }
    
    func layout() {
        view.backgroundColor = UIColor.white
        
        view.addSubview(firstNameLabel)
        firstNameLabel.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        
        view.addSubview(lastNameLabel)
        lastNameLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(firstNameLabel.snp.bottom).inset(20)
            make.height.equalTo(44)
        }
        
        view.addSubview(showLocationButton)
        showLocationButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}

private extension UILabel {
    static func makeFirstNameLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.blue
        return label
    }
    
    static func makeLastNameLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.orange
        return label
    }
}

private extension UIButton {
    static func makeButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }
}
