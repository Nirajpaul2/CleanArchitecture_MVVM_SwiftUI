//
//  HomeScreen.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 3/2/25.
//

import SwiftUI
import Combine
import Kingfisher

struct HomeScreen: View {
    @EnvironmentObject private var router: AppRouter
    @ObservedObject var homeViewModel: HomeViewModel
    @State private var isSheetPresented = false // Whether to show the sheet

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                SearchBarView() // Search bar
                
                ShoppingInfoSection(banners: homeViewModel.trendBannerList ?? []) // Shopping info
                
                TohomeSection(banners: homeViewModel.foodBannerList ?? []) // ToHome section
            }
            .padding()
            .onAppear {
                self.homeViewModel.fetchHomeBanner()
            }
            .onDisappear {
                homeViewModel.cancelSubscriptions()
            }
            .navigationBarHidden(true) // Hide the navigation bar
            // When using present() style
            .sheet(isPresented: $router.isPresenting, onDismiss: {
                // You can reset state or handle actions when the sheet is dismissed
            }) {
                if let view = router.presentedRouteView {
                    view
                }
            }
        }
    }
}

#Preview {
    // HomeView(homeViewModel: ViewControllerFactory.shared.makeHomeViewModel())
}
