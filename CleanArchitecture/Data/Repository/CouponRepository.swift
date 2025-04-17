//
//  CouponRepository.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 1/18/25.
//

import Foundation
import Combine


/**
 This corresponds to the Repository layer.
 It acts as an interface between the Domain layer and the Repository.
 
 Naming Convention: Repository / RepositoryInterface
 
 This is where internal and external data is used through DBs and external APIs.
 
 */
protocol CouponRepositoryInterface {
    func fetchCoupons(request: CouponRequestDTO) -> AnyPublisher<CouponEntityList, Error>
}


final class CouponRepository: CouponRepositoryInterface {
    
    private let couponService: CouponServiceProtocol
    
    init(couponService: CouponServiceProtocol) {
        self.couponService = couponService
    }
    
    func fetchCoupons(request: CouponRequestDTO) -> AnyPublisher<CouponEntityList, Error> {
        return couponService.fetchCouponList(request: request)
    }
}
