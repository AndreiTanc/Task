//
//  URL+Extension.swift
//  iOSAppTaskAndreiTanc
//
//  Created by Andrei Tanc on 08.12.2022.
//

import Foundation

extension URL {
    func appending(path: String) -> URL {
        appendingPathComponent(path, isDirectory: false)
    }

    func appending(queryParams: [String: Any]) -> URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else { return nil }
        components.queryItems = queryParams.map { key, value in
            URLQueryItem(name: key, value: "\(value)")
        }
        return components.url
    }
}
