//
//  MessagesListPresenter.swift
//  GitDMApp
//
//  Created by Tilakkumar Gondi on 02/08/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import Foundation


class MessagesListPresenter {
    
    fileprivate var dataLayer = DataLayer()
    var user: User
    
    var account_handler:String { return "@\(user.login ?? "")"}
    var userMessagesArray = [Message]()
    
    //Gives the indexpat to insert the new message at the end.
    var indexPathForlastMessage:IndexPath {
         return IndexPath(row: self.userMessagesArray.count-1, section: 0)
    }
    
    init(with user:User) {
        self.user = user
    }
    
    // Here we can load the messages stored in the persistent storage for the user
    func loadMessagesFromDB(finished:@escaping () -> Void)  {
        //Connect with the Data layer and fetche the stored messages with the userId property in Message Object.
        dataLayer.loadMessagesFor(user: user.id!) { (messageslist) in
            for messageEntity in messageslist {
                let msgTagValue:MessageTag = messageEntity.isSent ? MessageTag.Sent : MessageTag.Recieved
                let messageObj:Message = Message(msgTag: msgTagValue, message: messageEntity.message!, userId: Int(messageEntity.userId))
                self.userMessagesArray.append(messageObj)
            }
            finished()
        }
    }
    
    //Here we can handle the post request for a message.
    func sendMessage( messageStr:String, finished:(()->Void)) {
        
        let newMessage = Message(msgTag: .Sent, message: messageStr, userId: user.id!)
        self.userMessagesArray.append(newMessage)
        if dataLayer.save(messageObj: newMessage) {
            print("Saved message to DB")
        }
        finished()
    }
    
    
    // Here we can make the response handelinig call for messages
    func echoResponseFor(Message str:String, finished:(()->Void)) {
        let messageStr = "\(str) \(str)"
        let newMessage = Message(msgTag: .Recieved, message: messageStr, userId: user.id!)
        self.userMessagesArray.append(newMessage)
        if dataLayer.save(messageObj: newMessage) {
            print("Saved message to DB")
        }
        finished()
    }
    
}
