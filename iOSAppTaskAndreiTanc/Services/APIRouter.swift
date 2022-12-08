//
//  APIRouter.swift
//  iOSAppTaskAndreiTanc
//
//  Created by Andrei Tanc on 08.12.2022.
//

import Foundation
import Alamofire

enum ApiBaseURL: String {
    case dev = "https://jsonplaceholder.typicode.com"

    static var baseURLBasedOnCurrentEnvironment: ApiBaseURL {
        return .dev
    }
}

enum ApiEndpoints: String {
    case posts = "/posts"
    case user = "/users/{user_id}"
}

enum ApiRouter: ApiConfiguration {
    case posts
    case user(userId: String)
    
    var method: HTTPMethod {
        switch self {
        case .posts:
            return .get
        case .user:
            return .get
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .posts:
            return .body(.emptyBody)
        case .user:
            return .body(.emptyBody)
        }
    }
    
    var path: String {
        switch self {
        case .posts:
            return ApiEndpoints.posts.rawValue
        case .user(let userId):
            return ApiEndpoints.user.rawValue.replacingOccurrences(of: "{user_id}", with: userId)
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let baseUrl = ApiBaseURL.baseURLBasedOnCurrentEnvironment.rawValue

        var urlRequest = try URLRequest(url: baseUrl.asURL())
        try urlRequest.setup(withParameters: parameters, appendingPath: path)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        
        return urlRequest
    }
}
