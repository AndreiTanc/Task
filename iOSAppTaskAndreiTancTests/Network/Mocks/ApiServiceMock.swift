//
//  ApiServiceMock.swift
//  iOSAppTaskAndreiTancTests
//
//  Created by Andrei Tanc on 08.12.2022.
//

import Foundation
import CoreData
@testable import iOSAppTaskAndreiTanc

final class ApiServiceMock: ApiServiceProtocol, Mockable {
    func getPosts(withContext context: NSManagedObjectContext, completion: CompletionStatusCodableClosure<[Post]?>?) {
        completion?(loadJSON(filename: "PostsResponse", type: [Post].self, withContext: context))
    }
    
    func getUser(withId id: Int, completion: CompletionStatusCodableClosure<User?>?) {
        completion?(loadJSON(filename: "UserResponse", type: User.self))
    }
}
