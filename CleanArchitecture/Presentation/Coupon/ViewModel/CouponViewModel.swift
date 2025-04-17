//
//  CouponViewModel.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 1/18/25.
//

import Foundation
import Combine

// Enum defining actions related to coupons
enum CouponAction {
    case download(CouponEntity)
    case select(CouponEntity)
}

/**
This class serves as the ViewModel in the MVVM pattern.
1. Manages coupon-related business logic
2. Handles UI state management

 - State: Targets that should automatically reflect changes in the view through the @Published properties
 - Action: Targets related to user interface management
 - Feature: Manages business logic
 */
final class CouponViewModel: ObservableObject {
    
    // MARK: - State
    @Published var couponList: CouponEntityList?
    @Published var downloadedCoupon: CouponEntity?
    
    @Published var showToast: Bool = false
    @Published var toastMessage: String?
    @Published var errorMessage: String?
    
    private let couponUsecase: CouponUsecaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(couponUsecase: CouponUsecaseProtocol) {
        self.couponUsecase = couponUsecase
    }
    
    // MARK: - Action
    func handleAction(_ action: CouponAction) {
        switch action {
        case .download(let coupon):
            downloadCoupon(coupon)
        case .select(_):
            // Selection handling is done directly in the view
            break
        }
    }
    
    // MARK: - Feature
    func downloadCoupon(_ coupon: CouponEntity) {
        // Implement the actual download logic (e.g., API call) ~ only shows toast message
        self.downloadedCoupon = coupon
        self.toastMessage = "\(coupon.name ?? "") coupon has been downloaded."
        self.showToast = true
        
        // Hide the toast message after 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.showToast = false
        }
    }
    
    func loadCouponList() {
        let couponRequestDto = CouponRequestDTO(mcustNo: "", copnGbcd: "01", prfrYn: "N", ptcoId: nil)
        let response: AnyPublisher<CouponEntityList, Error> = couponUsecase.getCouponList(request: couponRequestDto)
        
        response
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let failure):
                    print("\(failure)")
                }
            }, receiveValue: { [weak self] coupons in
                self?.couponList = coupons
            })
            .store(in: &cancellables)
        
    }
}
