import UIKit

class UsersTableViewDataSource: NSObject, UITableViewDataSource {
    weak var tableView: UITableView? {
        didSet {
            tableView?.register(UsersTableViewCell.self)
        }
    }
    
    var users: [User] = [] {
        didSet {
            tableView?.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UsersTableViewCell = tableView.dequeueReusableCell(at: indexPath)
        cell.setUser(users[indexPath.row])
        return cell
    }
}
