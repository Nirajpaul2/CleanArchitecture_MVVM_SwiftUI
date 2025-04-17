//
//  ResponseWrapper.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 1/3/25.
//

import Foundation

struct ResponseWrapper<T: Decodable>: Decodable {
    let message: String?
    let code: String?
    let data: T?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decodeIfPresent(String.self, forKey: .message)
        code = try container.decodeIfPresent(String.self, forKey: .message)
        data = try container.decodeIfPresent(T.self, forKey: .data)
    }

    private enum CodingKeys: String, CodingKey {
        case message
        case code
        case data // Map the server response model to the data field
    }
}
