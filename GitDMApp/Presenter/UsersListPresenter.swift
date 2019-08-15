//
//  UsersListPresenter.swift
//  GitDMApp
//
//  Created by Tilakkumar Gondi on 02/08/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import Foundation


class UsersListPresenter {
    var userList = [User]()
    
    fileprivate var interactor = UsersInteractor()
    
    //To fetch the users list from the server.
    func loadUsers(finished:@escaping (()->Void),finishedWithError:@escaping( (ErrorResponse) -> Void))  {
        interactor.getAllUserFromServer(finished: { (usersList) in
            self.userList = usersList //this is now notified to the caller and presented on table.
            //Further here we can have the DB releated action to store the users list .
            DispatchQueue.main.async {
                finished()
            }
        }) { (errorResponse) in
            DispatchQueue.main.async {
                finishedWithError(errorResponse)
            }
        }
        
        
    }
}
