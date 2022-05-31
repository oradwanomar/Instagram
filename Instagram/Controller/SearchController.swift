//
//  SearchController.swift
//  Instagram
//
//  Created by Omar Ahmed on 19/05/2022.
//

import UIKit

private let reuseIdentifier = "usercell"
class SearchController : UITableViewController {
    
    var users : [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        UserService.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    func configureTableView(){
        view.backgroundColor = .systemBackground
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 64
    }
}

extension SearchController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        cell.user = users[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
