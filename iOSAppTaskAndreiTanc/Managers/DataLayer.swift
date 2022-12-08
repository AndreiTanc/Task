//
//  DataLayer.swift
//  iOSAppTaskAndreiTanc
//
//  Created by Andrei Tanc on 08.12.2022.
//

import Foundation

public typealias CompletionPostsClosure = (([Post]) -> Void)?

class DataLayer {
    private let apiService: ApiServiceProtocol
    private let coreDataManager: CoreDataManager
    
    init(apiService: ApiServiceProtocol, coreDataManager: CoreDataManager) {
        self.apiService = apiService
        self.coreDataManager = coreDataManager
    }
    
    func getPosts(completion: CompletionPostsClosure) {
        let localPosts = getLocalPosts()
        
        if localPosts.isEmpty {
            getAPIPosts(completion: completion)
        } else {
            completion?(localPosts)
            getAPIPosts(completion: completion)
        }
    }
    
    func refreshPosts(completion: CompletionPostsClosure) {
        getAPIPosts(completion: completion)
    }
    
    private func getLocalPosts() -> [Post] {
        coreDataManager.fetchAll(ofType: Post.self)
    }
    
    private func getAPIPosts(completion: CompletionPostsClosure = nil) {
        apiService.getPosts(withContext: coreDataManager.persistentContainer.viewContext) { [weak self] posts in
            guard let posts = posts else {
                completion?([])
                return
            }
            
            self?.getUsers(forPosts: posts, completion: completion)
        }
    }
    
    private func getUsers(forPosts posts: [Post], completion: CompletionPostsClosure = nil) {
        let group = DispatchGroup()
        
        for index in 0..<posts.count {
            group.enter()
            
            apiService.getUser(withId: Int(posts[index].userId)) { user in
                posts[index].userName = user?.name
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.coreDataManager.saveContext()
            completion?(posts)
        }
    }
}
