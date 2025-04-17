//
//  CultureRepositoryInterface.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 1/3/25.
//

import Foundation

protocol CultureRepositoryInterface {
    func fetchSearchResult(request: CultureSearchRequest,
                      completion: @escaping (Result<[CultureLecture], Error>) -> Void)
}



