//
//  DMAppRouter.swift
//  GitDMApp
//
//  Created by Tilakkumar Gondi on 02/08/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import Foundation
import UIKit

class DMAppRouter {
    
    func showMessagesView(from srcVC:UIViewController, for user:User) {
        let msgListPresenter = MessagesListPresenter(with: user)
        let vc:GitDMViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GitDMViewController") as! GitDMViewController
        vc.configure(with: msgListPresenter)
        
        srcVC.navigationController?.pushViewController(vc, animated: true)
    }
}
