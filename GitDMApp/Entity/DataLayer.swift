//
//  DataLayer.swift
//  GitDMApp
//
//  Created by Tilakkumar Gondi on 02/08/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import Foundation
import CoreData

class DataLayer {
    //This class was made to be used for placing the code related to the DB handling for Persistent store for messages and Users list data.
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GitDMApp")
       
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            container.viewContext.automaticallyMergesChangesFromParent = true
        })
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
}


//Helper Methods: To save and fetch messages.
extension DataLayer {
    func save(messageObj:Message) -> Bool {
        
        let messageEntity = NSEntityDescription.entity(forEntityName: "MessageEntity", in: mainContext)!
        let message = NSManagedObject.init(entity: messageEntity, insertInto: mainContext) as! MessageEntity
        
        message.isSent = (messageObj.msgTag == .Sent) ? true : false
        message.message = messageObj.message
        message.userId  = Int16(messageObj.userId)

        do{
            try mainContext.save()
            return true
        }catch let error as NSError{
            print("DB Error: \(error.localizedDescription)")
            return false
        }
    }
    
    func loadMessagesFor(user userid:Int, finished: @escaping ([MessageEntity]) -> Void) {
        
        let predicate = NSPredicate(format: "userId == %d", Int16(userid))
        let fetchRequest:NSFetchRequest<MessageEntity> = MessageEntity.fetchRequest()
        fetchRequest.predicate = predicate
        
        let userMessages = try! persistentContainer.viewContext.fetch(fetchRequest)
        
        finished(userMessages)
        
    }
}
