//
//  MainTabType.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 1/18/25.
//

import Foundation
import SwiftUI

enum MainTabType: String, CaseIterable {
    case home
    case cultureCenter
    case coupon
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .cultureCenter:
            return "Culture Center"
        case .coupon:
            return "Coupon"
        }
    }
    
    func imageName(selected: Bool) -> String {
        switch self {
        case .home:
            return "house.fill"
        case .cultureCenter:
            return "bag.fill"
        case .coupon:
            return "ticket.fill"
        }
    }
}
