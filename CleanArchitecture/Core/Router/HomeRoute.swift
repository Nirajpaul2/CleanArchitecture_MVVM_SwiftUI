//
//  HomeRoute.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 2/25/25.
//

import Foundation

enum HomeRoute: NavigationRoute {
    case homeScreen
    case shoppingInfoDetail(HomeBanner)
    case foodDetail(HomeBanner)
    case webViewExam(WebViewModel)
    case NativePushScreen
    case NativePresentScreen
}
