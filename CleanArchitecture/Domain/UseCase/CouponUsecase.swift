//
//  CouponService.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 1/18/25.
//

import Foundation
import Combine

/**
 This corresponds to the Usecase in the Domain layer.
 
 Naming Convention: Usecase / UsecaseInterface
 
 Business logic composed by domain experts should be defined here so that it can be reused in other projects.
 The business logic for the Coupon feature's UseCase should be defined below.
 
 */
protocol CouponUsecaseProtocol {
    func getCouponList(request: CouponRequestDTO) -> AnyPublisher<CouponEntityList, Error>
}

final class CouponUsecase: CouponUsecaseProtocol {

    private let couponRepository: CouponRepositoryInterface

    init(couponRepository: CouponRepositoryInterface) {
        self.couponRepository = couponRepository
    }
    
    func getCouponList(request: CouponRequestDTO) -> AnyPublisher<CouponEntityList, Error> {
        return couponRepository.fetchCoupons(request: request)
    }
}
