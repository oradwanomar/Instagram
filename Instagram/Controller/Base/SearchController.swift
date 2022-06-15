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
    
    //MARK: Properties
    
    var users : [User] = []
    var filteredUsers : [User] = []
    let pvm = ProfileViewModel()
    private let searchController = UISearchController(searchResultsController: nil)
    var isSearchMode : Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureTableView()
        fetchUsers()
    }
    
    //MARK: Helper Functions
    
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
    
    func configureSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
}

extension SearchController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchMode ? filteredUsers.count : users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        let user = isSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        cell.userViewModel = UserViewModel(user: user)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = isSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        let profile = ProfileController(user: user)
        navigationController?.pushViewController(profile, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension SearchController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else {return}
        filteredUsers = users.filter({$0.username.contains(searchText) ||
            $0.fullname.lowercased().contains(searchText)})
        self.tableView.reloadData()
    }
}
