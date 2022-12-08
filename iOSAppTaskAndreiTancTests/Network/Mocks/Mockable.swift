//
//  Mockable.swift
//  iOSAppTaskAndreiTancTests
//
//  Created by Andrei Tanc on 08.12.2022.
//

import Foundation
import CoreData

protocol Mockable: AnyObject {
    var bundle: Bundle { get }
    func loadJSON<T: Decodable>(filename: String, type: T.Type, withContext context: NSManagedObjectContext?) -> T
}

extension Mockable {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
    
    func loadJSON<T: Decodable>(filename: String, type: T.Type, withContext context: NSManagedObjectContext? = nil) -> T {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to load json file")
        }
        
        do {
            let data = try Data(contentsOf: path)
            
            let decoder = JSONDecoder()
            if let context = context {
                decoder.userInfo[CodingUserInfoKey.managedObjectContext] = context
            }
            let decodedObject = try decoder.decode(T.self, from: data)
            
            return decodedObject
        } catch {
            print(error)
            fatalError("Failed to decode the json")
        }
    }
}

