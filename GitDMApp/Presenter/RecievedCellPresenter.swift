//
//  RecievedCellPresenter.swift
//  GitDMApp
//
//  Created by Tilakkumar Gondi on 02/08/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import Foundation

class RecievedCellPresenter {
    
    var message:Message!
    
    var messageTag:MessageTag { return message.msgTag}
    var messageTxt:String {return message.message}
    var userId:Int { return message.userId}
    
    init(with message:Message) {
        self.message = message
    }
}
