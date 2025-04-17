//
//  ErrorResponse.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 1/3/25.
//

import Foundation

struct ErrorResponse: Decodable, Equatable {
    public let statusCode: String
    public let responseMessage: String
}
