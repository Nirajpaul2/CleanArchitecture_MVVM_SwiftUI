//
//  CouponRowView.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 1/18/25.
//

import SwiftUI
import Kingfisher

struct CouponRowView: View {
    let coupon: CouponEntity
    let onAction: (CouponAction) -> Void

    var body: some View {
        HStack(spacing: 12) {
            // Display the coupon image if a valid URL exists
            if let url = URL(string: coupon.titleImage ?? "") {
                KFImage(url)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFill() // Ensure the image scales to fill the space
                    .clipShape(Circle()) // Clip the image to a circle shape
            }
            
            Spacer()
                
            // Display the coupon name as text
            Text(coupon.name)
            
            // Download button
            DownloadButton {
                onAction(.download(coupon))
            }

            Spacer()
        }
        .padding(.vertical, 8)
        .onTapGesture {
            // Handle the selection action when tapped
            onAction(.select(coupon))
        }
    }
}

#Preview {
    let coupon = CouponEntity(
        id: "test-id",
        campId: "",
        ofrId: "",
        name: "Tapas and Pinchos",
        titleImage: "https://contents.kyobobook.co.kr/sih/fit-in/458x0/pdt/9788970417981.jpg",
        couponType: .coupon
    )
    
    return CouponRowView(coupon: coupon, onAction: { action in
        print(action)
    })
}
