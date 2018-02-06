import UIKit

class UsersTableViewCell: UITableViewCell, Identifiable {
    func setUser(_ user: User) {
        self.textLabel?.text = user.firstName
        self.accessoryType = .disclosureIndicator
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.textLabel?.text = nil
        self.accessoryType = .none
    }
}
