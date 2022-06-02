//
//  SearchController.swift
//  Instagram
//
//  Created by Omar Ahmed on 19/05/2022.
//

import UIKit
import Firebase

private let reuseIdentifier = "usercell"
class SearchController : UITableViewController {
    
    var users : [User] = []
    let pvm = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchUsers()
    }
    
    func fetchUsers(){
        UserService.fetchUsers { users in
            let filterd = users.filter {$0.username != self.pvm.username}
            self.users = filterd
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
        cell.userViewModel = UserViewModel(user: users[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let profileVM = ProfileViewModel()
        let profile = ProfileController(user: users[indexPath.row])
        navigationController?.pushViewController(profile, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
