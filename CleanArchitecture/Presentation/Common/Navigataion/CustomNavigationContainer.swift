import SwiftUI

/**
 A view that provides the appropriate navigation container based on the iOS version.
 
 It uses `NavigationStack` for iOS 16 and later, and `NavigationView` for iOS 15.
 
 - Parameters:
 - navigator: An object that manages the navigation path.
 - content: The root view of the container.
 - destination: A closure that creates the destination view based on the route.
 
 - Note: This view manages a single navigation stack and ensures compatibility with iOS versions.
 */
struct CustomNavigationContainer<R: NavigationRoute, Content: View, Destination: View>: View {
    @ObservedObject var navigator: TabNavigationManager<R>
    let content: Content
    let destination: (R) -> Destination
    
    init(
        navigator: TabNavigationManager<R>,
        @ViewBuilder content: () -> Content,
        @ViewBuilder destination: @escaping (R) -> Destination
    ) {
        self.navigator = navigator
        self.content = content()
        self.destination = destination
    }
    
    var body: some View {
        if #available(iOS 16.0, *) {
            // Use NavigationStack for iOS 16 and later
            NavigationStack(path: $navigator.routes) {
                content.navigationDestination(for: R.self) { route in
                    destination(route)
                }
            }
        } else {
            // Use NavigationView for iOS 15
            NavigationView {
                let activeRoute = navigator.routes
                // To avoid an issue where NavigationLink intermittently exits the view, use EmptyView() and hide it.
                NavigationLink(destination: destination(activeRoute.last!)) {
                    EmptyView()
                }
                .hidden()
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
