//
//  SceneDelegate.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 1/1/25.
//

import UIKit
import SwiftUI
import Swinject

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let _ = (scene as? UIWindowScene) else { return }
        
        if let windowScene = scene as? UIWindowScene {
            DIContainer.shared.registerDependencies()

            self.window = UIWindow(windowScene: windowScene)

            let router = AppRouter()
            
            let couponViewModel = DIContainer.shared.resolve(CouponViewModel.self)!
            let homeViewModel = DIContainer.shared.resolve(HomeViewModel.self)!
            
            let mainTabView = MainTabViewController(homeViewModel: homeViewModel, couponViewModel: couponViewModel)
                .environmentObject(router)

            let hostingController = UIHostingController(rootView: mainTabView)

            self.window?.rootViewController = hostingController
            self.window?.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }


}

