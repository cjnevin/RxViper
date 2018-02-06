import UIKit
import RxSwift

class UsersViewController<T: UserNavigating>: UITableViewController, UsersView {
    private let dataSource = UsersTableViewDataSource()
    
    var selectedUser = PublishSubject<User>()
    var presenter: UsersPresenter<UsersViewController, T>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        dataSource.tableView = tableView
        presenter?.attachView(self)
    }
    
    deinit {
        presenter?.detachView()
    }
    
    func showUsers(_ users: [User]) {
        dataSource.users = users
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedUser.onNext(dataSource.users[indexPath.row])
    }
}
