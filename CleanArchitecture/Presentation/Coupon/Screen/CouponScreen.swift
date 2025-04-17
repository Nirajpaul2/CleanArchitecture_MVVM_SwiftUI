//
//  CouponView.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 1/18/25.
//

import SwiftUI
import Kingfisher

struct CouponScreen: View {
    @EnvironmentObject private var router: AppRouter
    @ObservedObject var couponViewModel: CouponViewModel
    
    var body: some View {
        ZStack {
            CouponListView(
                coupons: couponViewModel.couponList?.coupons ?? [],
                onAction: { action in
                    switch action {
                    case .select(let coupon):
                        router.navigate(.push, route: CouponRoute.couponDetail(coupon))
                    default:
                        couponViewModel.handleAction(action)
                    }
                }
            )
            .onAppear {
                couponViewModel.loadCouponList() // Load coupon list when the view appears
            }
            .toast(message: couponViewModel.toastMessage ?? "", isPresented: $couponViewModel.showToast) // Show toast message if any
        }
        .navigationTitle("Coupons") // "쿠폰" translated to "Coupons"
    }
}
