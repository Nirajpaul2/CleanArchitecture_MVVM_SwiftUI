//
//  NavigationProtocol.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 2/25/25.
//

import Foundation
import SwiftUI

enum NavigationAction {
    case push
    case pop
    case popToRoot
    case present
    case navigateToTab(MainTabType, Any?)
}

protocol NavigationRoute: Hashable {}

protocol NavigationManaging: ObservableObject {
    associatedtype Route: NavigationRoute
    
    var routes: [Route] { get set }
    
    func push(_ route: Route)
    func pop()
    func popToRoot()
    func present(_ route: Route)
    func dismiss()
}
