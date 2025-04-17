//
//  CultureUseCase.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 3/2/25.
//

import Foundation

protocol CultureUseCaseProtocol {
    func fetchCultureList(cultureSearchRequest: CultureSearchRequest,
                 completion: @escaping (Result<[CultureLecture], Error>) -> Void)
}

final class CultureUseCase: CultureUseCaseProtocol {
    private let cultureRepository: CultureRepositoryInterface
    
    init(cultureRepository: CultureRepositoryInterface) {
        self.cultureRepository = cultureRepository
    }
    
    func fetchCultureList(cultureSearchRequest: CultureSearchRequest, completion: @escaping (Result<[CultureLecture], Error>) -> Void) {
        cultureRepository.fetchSearchResult(request: cultureSearchRequest, completion: completion)
    }
}
