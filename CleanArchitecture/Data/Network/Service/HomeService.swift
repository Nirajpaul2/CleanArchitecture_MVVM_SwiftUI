//
//  HomeService.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 1/3/25.
//

import Foundation
import Combine
import Moya

protocol HomeServiceProtocol {
    func fetchHomeInfoList(request: HomeBannerRequest) -> AnyPublisher<HomeBannerResponse, Error>
                                
}

final class HomeService: BaseService<EHyundaiAppAPI>, HomeServiceProtocol {
    public func fetchHomeInfoList(request: HomeBannerRequest) -> AnyPublisher<HomeBannerResponse, Error> {
        requestObjectInCombine(.getHomeInfoList(request: request))
    }
}

