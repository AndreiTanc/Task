//
//  CoreDataManager.swift
//  iOSAppTaskAndreiTanc
//
//  Created by Andrei Tanc on 08.12.2022.
//

import Foundation
import CoreData

protocol TaskDataProtocol {
    func initWithData(_ data: [String: Any])
}

fileprivate let kDataModelName = "TaskData"
open class CoreDataManager {
    public init() {}

    public lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: kDataModelName)
        
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    public static let model: NSManagedObjectModel = {
      let modelURL = Bundle.main.url(forResource: kDataModelName, withExtension: "momd")!
      return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    func fetchAll<TaskItem>(ofType type: TaskItem.Type) -> [TaskItem] where TaskItem: NSManagedObject {
        do {
            let taskItems = try persistentContainer.viewContext.fetch(TaskItem.fetchRequest())
            return taskItems as? [TaskItem] ?? []
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func insertItem<TaskItem>(ofType type: TaskItem.Type, withData data: [String: Any]) where TaskItem: NSManagedObject & TaskDataProtocol {
        let taskItem = TaskItem(context: persistentContainer.viewContext)
        taskItem.initWithData(data)
        
        saveContext()
    }
    
    func delete<TaskItem>(_ item : TaskItem, ofType type: TaskItem.Type) where TaskItem: NSManagedObject {
        persistentContainer.viewContext.delete(item)
        saveContext()
    }
    
    func saveContext () {
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
