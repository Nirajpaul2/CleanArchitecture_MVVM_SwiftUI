//
//  CouponDetailView.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 1/18/25.
//

import SwiftUI
import Kingfisher

struct CouponDetailView: View {
    let coupon: CouponEntity
    
    @EnvironmentObject private var router: AppRouter
    var body: some View {
        ScrollView {
            VStack {
                // Close button
                HStack {
                    Spacer()
                    Button(action: {
                        router.navigate(.pop)
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .padding()
                    }
                }
                
                // Coupon title
                Text(coupon.name)

                // Coupon image
                if let url = URL(string: coupon.titleImage ?? "") {
                    KFImage(url)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .scaledToFill() // Set image to fully fill the circle
                        .clipShape(Circle()) // Clip into a circle shape
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
                Button(action: {}) {
                Text("Receive Coupon")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.indigo)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            .background(Color.white)
        }
        .onDisappear {
            // You can add any logic to execute when the view disappears
        }
    }
}

#Preview {
    let coupon = CouponEntity(
        id: "test-id",
        campId: "",
        ofrId: "",
        name: "Test Coupon",
        titleImage: "https://image.h-point.co.kr//images_share/cp/cp0001/2025/0224/1815/20250224181554944.jpg",
        couponType: .coupon
    )
    
    return CouponDetailView(coupon: coupon)
        .environmentObject(AppRouter())
}
