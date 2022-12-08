//
//  TaskViewModel.swift
//  iOSAppTaskAndreiTanc
//
//  Created by Andrei Tanc on 08.12.2022.
//

import Foundation

public typealias CompletionClosure = (() -> Void)?

class TaskViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var shouldPresentAlert: Bool = false
    
    private let dataLayer: DataLayer
    
    init(dataLayer: DataLayer) {
        self.dataLayer = dataLayer
    }
    
    func getPosts(completion: CompletionClosure = nil) {
        dataLayer.getPosts { [weak self] posts in
            self?.posts = posts
        }
    }
    
    func refreshLogic() {
        dataLayer.refreshPosts { [weak self] posts in
            if posts.isEmpty {
                self?.shouldPresentAlert = true
                return
            }
            
            self?.posts = posts
        }
    }
}

extension TaskViewModel {
    static var mock: TaskViewModel {
        return .init(dataLayer: DataLayer(apiService: ApiService(), coreDataManager: CoreDataManager()))
    }
}
