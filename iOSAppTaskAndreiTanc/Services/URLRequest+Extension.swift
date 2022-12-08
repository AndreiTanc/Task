//
//  URLRequest+Extension.swift
//  iOSAppTaskAndreiTanc
//
//  Created by Andrei Tanc on 08.12.2022.
//

import Foundation

extension URLRequest {
    mutating func setup(withParameters parameters: RequestParams, appendingPath path: String) throws {
        switch parameters {
        case .body(let bodyParams):
            url = url?.appending(path: path)
            if !bodyParams.isEmpty {
                httpBody = try JSONSerialization.data(withJSONObject: bodyParams, options: [.withoutEscapingSlashes])
            }
        }
    }
}
