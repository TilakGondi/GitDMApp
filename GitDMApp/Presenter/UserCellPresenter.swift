//
//  UserCellPresenter.swift
//  GitDMApp
//
//  Created by Tilakkumar Gondi on 02/08/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import Foundation


class UserCellPresenter {
    
    var user:User
    
    fileprivate var networkLayer = NetworkLayer()
    var userLoginName:String  {return "@\(user.login ?? "")"}
    
    
    init(with user:User) {
        self.user = user
        
    }
    
    // To Load the image from the avatar_url for the users.
    func loadProfileImage(finished:@escaping (Data?)->Void) {
        let imageUrl:URL = URL(string: user.avatar_url ?? "")!
        networkLayer.loadDataForUrl(url: imageUrl, finished: { (imageData, error) in
            if error == nil {
                guard let data = imageData else {
                    finished(nil)
                    return
                }
                //Calling the loading of the image view in main thread
                DispatchQueue.main.async {
                    finished(data)
                }
            }else{
                finished(nil)
            }
        })
        
        
        
    }
}
