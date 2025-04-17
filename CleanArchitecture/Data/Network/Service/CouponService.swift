//
//  CouponService.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 1/3/25.
//

import Foundation
import Combine
import Moya

protocol CouponServiceProtocol {
    func fetchCouponList(request: CouponRequestDTO) -> AnyPublisher<CouponEntityList, Error>
}

final class CouponService: BaseService<HpointAPI>, CouponServiceProtocol {
    public func fetchCouponList(request: CouponRequestDTO) -> AnyPublisher<CouponEntityList, Error> {
        requestObjectInCombine(.fetchCouponList(request: request))
    }
}
