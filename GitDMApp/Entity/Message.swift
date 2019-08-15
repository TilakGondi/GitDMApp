//
//  Message.swift
//  GitDMApp
//
//  Created by Tilakkumar Gondi on 02/08/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import Foundation

//Enum used to denote if the message was sent or recieved
enum MessageTag {
    case Sent
    case Recieved
}

//Model object used to store the message sent and recieved by the user
struct Message {
    var msgTag:MessageTag
    var message: String
    var userId: Int
}
