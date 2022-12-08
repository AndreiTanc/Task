//
//  Post+CoreDataProperties.swift
//  iOSAppTaskAndreiTanc
//
//  Created by Andrei Tanc on 08.12.2022.
//
//

import Foundation
import CoreData

enum DecoderConfigurationError: Error {
    case missingManagedObjectContext
}
extension CodingUserInfoKey {
    public static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

@objc(Post)
public class Post: NSManagedObject, Identifiable, Decodable {
    @NSManaged public var id: Int32
    @NSManaged public var userId: Int32
    @NSManaged public var title: String?
    @NSManaged public var userName: String?
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    enum CodingKeys: CodingKey {
        case id, userId, title, userName
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int32.self, forKey: .id)
        self.userId = try container.decode(Int32.self, forKey: .userId)
        self.title = try? container.decode(String.self, forKey: .title)
        self.userName = try? container.decode(String.self, forKey: .userName)
    }
}
