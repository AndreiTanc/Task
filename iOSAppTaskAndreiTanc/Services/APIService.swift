//
//  APIService.swift
//  iOSAppTaskAndreiTanc
//
//  Created by Andrei Tanc on 08.12.2022.
//

import Foundation
import Alamofire
import CoreData

protocol ApiServiceProtocol {
    func getPosts(withContext context: NSManagedObjectContext, completion: CompletionStatusCodableClosure<[Post]?>?)
    func getUser(withId id: Int, completion: CompletionStatusCodableClosure<User?>?)
}

class ApiService: ApiServiceProtocol {
    public static var shared: ApiService = {
        let apiService = ApiService()
        return apiService
    }()
    
    func getPosts(withContext context: NSManagedObjectContext, completion: CompletionStatusCodableClosure<[Post]?>? = nil) {
        let decoder = JSONDecoder()
        decoder.userInfo[CodingUserInfoKey.managedObjectContext] = context
        
        performRequest(modelType: [Post].self, configuration: ApiRouter.posts, decoder: decoder, completion: completion)
    }
    
    func getUser(withId id: Int, completion: CompletionStatusCodableClosure<User?>? = nil) {
        performRequest(modelType: User.self, configuration: ApiRouter.user(userId: "\(id)"), completion: completion)
    }
    
    private func performRequest<Model: Decodable>(modelType: Model.Type, configuration: ApiConfiguration,
                                                  decoder: JSONDecoder = JSONDecoder(), completion: CompletionStatusCodableClosure<Model?>? = nil) {
        AF.request(configuration).responseDecodable(of: Model.self, decoder: decoder) { response in
            switch response.result {
            case .success(let decodedData):
                completion?(decodedData)
            case let .failure(error):
                print(error.localizedDescription)
                completion?(nil)
            }
        }
    }
}
