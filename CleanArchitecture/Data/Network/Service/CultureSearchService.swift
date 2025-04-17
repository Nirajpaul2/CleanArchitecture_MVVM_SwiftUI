//
//  CultureSearchService.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 1/4/25.
//

import Foundation
import Moya

protocol CultureServiceProtocol {
    func getCultureLectureSearchList(request: CultureSearchRequest,
                                completion: @escaping (Result<CultureSearchResponse, Error>) -> Void)
}

final class CultureService: CultureServiceProtocol {
    private lazy var provider = MoyaProvider<EHyundaiAppAPI>(plugins: [MoyaLoggingPlugin()])
    
    func getCultureLectureSearchList(request: CultureSearchRequest,
                                completion: @escaping (Result<CultureSearchResponse, Error>) -> Void) {
        provider.request(.getCultureLectureSearchList(request: request)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder()
                        let networkResult = try decoder.decode(CultureSearchResponse.self, from: response.data)
                        completion(.success(networkResult))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
}
