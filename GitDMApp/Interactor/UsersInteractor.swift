//
//  UsersInteractor.swift
//  GitDMApp
//
//  Created by Tilakkumar Gondi on 02/08/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import Foundation

class UsersInteractor {
    var usersList = [User]()
    
    fileprivate var networkLayer = NetworkLayer()
    fileprivate var defaultApiError = ErrorResponse(message: "Something went wrong, try again later.", documentation_url: "")
    
  //Connect with the network layer to fetch the list of users fromt he server
    func getAllUserFromServer(finished:@escaping (([User]) -> Void), finishedWithError: @escaping((ErrorResponse) -> Void)){
        let urlStr = "https://api.github.com/users"
        guard let url = URL(string: urlStr) else {
            return
        }
        networkLayer.loadDataForUrl(url: url) { [unowned self](data, error) in
            guard let data = data else {
                finishedWithError(self.defaultApiError)
                return
            }
            if error != nil  {
                guard let responseError = self.getDecodedAPIError(from: data) else {
                    finishedWithError(self.defaultApiError)
                    return
                }
                finishedWithError(responseError)
            }else{
                self.usersList = self.getDecodedUsersListFrom(data: data)
                finished(self.usersList)
            }
            
        }
    }
    
    //To decode the JSON response recieved from the server and form the array of User model object
    fileprivate func getDecodedUsersListFrom(data: Data) -> Array<User> {
        do{
            let userList = try JSONDecoder().decode(Array<User>.self, from: data)
            print(userList.count)
            return userList
        }catch{
            print(error.localizedDescription)
            return [User]()
        }
    }
    
    fileprivate func getDecodedAPIError(from data:Data) -> ErrorResponse? {
        do{
            let apiError = try JSONDecoder().decode(ErrorResponse.self, from: data)
            return apiError
        }catch{
            print(error.localizedDescription)
            return nil
        }
    }
}
