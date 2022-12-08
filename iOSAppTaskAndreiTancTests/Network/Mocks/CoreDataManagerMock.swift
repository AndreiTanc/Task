//
//  CoreDataManagerMock.swift
//  iOSAppTaskAndreiTancTests
//
//  Created by Andrei Tanc on 08.12.2022.
//

import Foundation
import CoreData
import iOSAppTaskAndreiTanc

class CoreDataManagerMock: CoreDataManager {
    override init() {
        super.init()
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(
            name: "TaskData",
            managedObjectModel: CoreDataManager.model)
        
        container.persistentStoreDescriptions = [persistentStoreDescription]
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        persistentContainer = container
    }
}
