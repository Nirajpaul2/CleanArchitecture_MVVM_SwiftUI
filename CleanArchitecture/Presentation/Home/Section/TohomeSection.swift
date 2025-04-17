//
//  TohomeSection.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 3/2/25.
//

import SwiftUI
import Kingfisher

struct TohomeSection: View {
    @EnvironmentObject private var router: AppRouter
    let banners: [HomeBanner]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Hyundai Food Hall ToHome") // Translated from "현대식품관 투홈"
                    .font(.headline)
                    .bold()
                Spacer()
                Button(action: {
                    router.navigate(.push, route: HomeRoute.webViewExam(WebViewModel(url: LinkUrl.WEB_TO_HOME, method: "S")))
                }) {
                    Text("See more >") // Translated from "더보기 >"
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(banners, id: \.title) { banner in
                    TohomeCardView(banner: banner)
                        .onTapGesture {
                            router.navigate(.push, route: HomeRoute.foodDetail(banner))
                        }
                }
            }
        }
    }
}
