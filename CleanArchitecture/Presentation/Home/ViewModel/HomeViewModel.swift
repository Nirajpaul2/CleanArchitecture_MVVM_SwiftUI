//
//  HomeViewModel.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 1/2/25.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var foodBannerList: [HomeBanner]?
    @Published var trendBannerList: [HomeBanner]?
    @Published var noticeBannerList: [HomeBanner]?
    
    private let homeUseCase: HomeUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(homeUseCase: HomeUseCaseProtocol) {
        self.homeUseCase = homeUseCase
    }
    
    func fetchHomeBanner() {
        homeUseCase.fetchHomeBanners(request: HomeBannerRequest(stCd: "400"))
            .sink { completion in
                switch completion {
                    case .finished:
                        print("Network call successful")
                    case .failure(let error):
                        print("Network call failed: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] homeEntity in
                self?.foodBannerList = Array(homeEntity.foodBannerList.prefix(6))
                self?.trendBannerList = Array(homeEntity.trendBannerList.prefix(4))
                self?.noticeBannerList = homeEntity.noticeBannerList
            }
            .store(in: &cancellables)
    }
    
    func cancelSubscriptions() {
        cancellables.removeAll()
    }
}
