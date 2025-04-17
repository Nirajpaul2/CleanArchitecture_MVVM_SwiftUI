//
//  APIError.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 1/18/25.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed(String)
    case decodingFailed
    case network(statusCode: Int, response: ErrorResponse)
    case unknown
    
    init(error: Error, statusCode: Int? = 0, response: ErrorResponse) {
        guard let statusCode else { self = .unknown ; return }
        
        self = .network(statusCode: statusCode, response: response)
    }
}
