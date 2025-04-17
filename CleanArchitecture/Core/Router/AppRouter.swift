import SwiftUI
import Combine

/**
 A router system that manages the navigation state for the entire app.
 
 TabNavigationManager manages the navigation paths for each tab,
 and AppRouter controls the transition between tabs and overall navigation flow.
 
 Key Features:
 - Independent navigation stack management for each tab
 - Transition between tabs and navigation to specific routes
 - Handling navigation actions such as push, pop, popToRoot, etc.
 */

// Tab-specific navigation manager (manages a single path)
class TabNavigationManager<R: NavigationRoute>: NavigationManaging {

    var objectWillChange = ObservableObjectPublisher()
    
    // Single path stack (for all iOS versions)
    @Published var routes: [R] = [] {
        didSet {
            print("Routes updated: \(routes.count)")
            objectWillChange.send()
        }
    }
    
    func push(_ route: R) {
        print("Pushing route: \(route)")
        routes.append(route)
    }
    
    func pop() {
        if !routes.isEmpty {
            routes.removeLast()
        }
    }
    
    func popToRoot() {
        routes.removeAll()
    }
    
    func present(_ route: R) {
        print("Present route: \(route)")
        routes.append(route)
    }
    
    func dismiss() {
        if !routes.isEmpty {
            routes.removeLast()
        }
    }
    
}

// Class managing routing for the entire app
class AppRouter: ObservableObject {
    // Navigation managers for each tab
    @Published var homeNavigator = TabNavigationManager<HomeRoute>()
    @Published var cultureCenterNavigator = TabNavigationManager<CultureCenterRoute>()
    @Published var couponNavigator = TabNavigationManager<CouponRoute>()
    
    // Currently selected tab
    @Published var selectedTab: MainTabType = .home
    @Published var isTabViewVisible: Bool = true
    // View state for presenting a route
    @Published var presentedRouteView: AnyView? = nil
    @Published var isPresenting = false
    @Published var shouldPresentModal = false
    
    func presentModal() {
        shouldPresentModal = true
    }

    func dismissModal() {
        self.shouldPresentModal = false
        self.isPresenting = false
        self.presentedRouteView = nil
    }
    
    // Navigate to a specific tab
    func switchTab(to tab: MainTabType) {
        selectedTab = tab
    }
    
    // Handle navigation actions
    func navigate(_ action: NavigationAction, route: Any? = nil) {
        switch selectedTab {
        case .cultureCenter:
            performNavigation(action, route: route as? CultureCenterRoute, navigator: cultureCenterNavigator)
        case .coupon:
            performNavigation(action, route: route as? CouponRoute, navigator: couponNavigator)
        case .home:
            performNavigation(action, route: route as? HomeRoute, navigator: homeNavigator)
        }
    }
    
    func navigateToOtherView(_ action: NavigationAction, nativeScreenName: NativeScreenName, route: Any? = nil) {
        switch nativeScreenName {
        case .cultureCenter:
            performNavigation(action, route: route as? CultureCenterRoute, navigator: cultureCenterNavigator)
        case .coupon:
            performNavigation(action, route: route as? CouponRoute, navigator: couponNavigator)
        case .home:
            performNavigation(action, route: route as? HomeRoute, navigator: homeNavigator)
        case .NativePushScreen:
            performNavigation(action, route: route as? HomeRoute, navigator: homeNavigator)
            
        case .NativePresentScreen:
            performNavigation(action, route: route as? HomeRoute, navigator: homeNavigator)
        }
    }
    
    func performNavigation<R: NavigationRoute>(_ action: NavigationAction, route: R?, navigator: TabNavigationManager<R>) {
        DispatchQueue.main.async {
            switch action {
            case .push:
                if let route = route {
                    navigator.push(route)
                    self.objectWillChange.send()
                }
            case .pop:
                navigator.pop()
                self.objectWillChange.send()
            case .popToRoot:
                navigator.popToRoot()
                self.objectWillChange.send()
            case .present:
                if let route = route {
                    self.presentedRouteView = self.convertToView(route: route)
                    self.isPresenting = true
                    self.objectWillChange.send()
                }
            case .navigateToTab(let tab, let route):
                self.selectedTab = tab
                if let route = route {
                    self.navigate(.push, route: route)
                }
            }
        }
    }
    
    // Move to another tab while navigating to a specific screen (unwind feature)
    func navigateToTab(_ tab: MainTabType, route: Any? = nil) {
        DispatchQueue.main.async {
            self.selectedTab = tab
            
            // Add route to the selected tab
            if let route = route {
                self.navigate(.push, route: route)
            }
        }
    }
    
    //
    private func convertToView<R: NavigationRoute>(route: R) -> AnyView {
        // Branch the screen based on the route type
        if route is HomeRoute {
            return AnyView(NativePresentScreen())
        } else if route is CouponRoute {
            return AnyView(CouponScreen(couponViewModel: DIContainer.shared.resolve(CouponViewModel.self)!))
        } else {
            return AnyView(EmptyView())
        }
    }
}
