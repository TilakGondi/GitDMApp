//
//  UsersListViewController.swift
//  GitDMApp
//
//  Created by Tilakkumar Gondi on 02/08/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import UIKit

class UsersListViewController: UIViewController {
    @IBOutlet weak var usersListTable: UITableView!
    @IBOutlet weak var activitiyIndicator: UIActivityIndicatorView!
    
    fileprivate var presenter: UsersListPresenter!
    
    fileprivate var router:DMAppRouter = DMAppRouter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.activitiyIndicator.startAnimating()
        self.usersListTable.delegate = self
        self.usersListTable.dataSource = self
        presenter  = UsersListPresenter()
        
        //Load the users from the server on launch
        presenter.loadUsers(finished: { [unowned self] in
            self.usersListTable.reloadData()
            self.activitiyIndicator.stopAnimating()
        }) { [unowned self](errorResponse) in
            self.activitiyIndicator.stopAnimating()
            self.showAlertFor(Error: errorResponse)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles  = true
        self.title = "Users List"
    }
}


//Table View Data source methods
extension UsersListViewController:UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = presenter.userList[indexPath.row]
        
        let cell = UserCell.dequeue(for: tableView, for: indexPath, with: user)
        
        return cell
    }
}

//Table View Delegate methods
extension UsersListViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = presenter.userList[indexPath.row]
        router.showMessagesView(from: self, for: user) // To navigate to the DM messaging screen with the selected user info
    }
    
    
}


extension UsersListViewController {
    
    func showAlertFor(Error error:ErrorResponse) {
        let alert = UIAlertController.init(title: "Error", message: error.message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "OK", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}
