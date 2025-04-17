//
//  HomeUseCase.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 3/8/25.
//

import Foundation
import Combine

protocol HomeUseCaseProtocol {
    func fetchHomeBanners(request: HomeBannerRequest) -> AnyPublisher<HomeEntity, Error>
}

final class HomeUseCase: HomeUseCaseProtocol {
    private let homeRepository: HomeRepositoryInterface
    
    init(homeRepository: HomeRepositoryInterface) {
        self.homeRepository = homeRepository
    }
    
    func fetchHomeBanners(request: HomeBannerRequest) -> AnyPublisher<HomeEntity, Error> {
        return homeRepository.fetchHomeInfo(request: request)
    }
}
