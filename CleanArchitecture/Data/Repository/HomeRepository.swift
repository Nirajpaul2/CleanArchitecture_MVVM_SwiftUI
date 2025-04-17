//
//  HomeRepository.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 3/2/25.
//

import Foundation
import Combine

final class HomeRepository {
    private let homeService: HomeServiceProtocol

    init(homeService: HomeServiceProtocol) {
        self.homeService = homeService
    }
}

extension HomeRepository: HomeRepositoryInterface {
    // Combine Popup & New Open, Trend & Preference, and Hyundai Food Court To Home lists into one array and return
    func fetchHomeInfo(request: HomeBannerRequest) -> AnyPublisher<HomeEntity, Error> {
        homeService.fetchHomeInfoList(request: request)
            .flatMap { response -> AnyPublisher<HomeEntity, Error> in
                    return Just(response.toDomain())
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    private func mapToHomeBannerList<T>(_ list: [T]?) -> [HomeBanner] where T: HomeBannerListProtocol {
        return list?.compactMap { banner in
            HomeBanner(
                image: banner.image ?? "",
                dcRate: banner.dcRate ?? "",
                price: banner.price ?? "",
                link: banner.link ?? "",
                badgeNm: banner.badgeNm ?? "",
                place: banner.place ?? "",
                originPrice: banner.originPrice ?? "",
                title: banner.title ?? "",
                descript: banner.descript ?? ""
            )
        } ?? []
    }
}
