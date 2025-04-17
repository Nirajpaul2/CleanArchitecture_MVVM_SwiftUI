//
//  DIContainer.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 1/3/25.
//

import Foundation
import Swinject
import Moya

/**
 Dependency injection container.
 This can manage the navigation router, appearance controller, and other objects related to dependency injection.
 */

// MARK: TODO Should be modified to modularize dependency injection with assembly
protocol Assembly {
    func assemble(container: Container)
}

// Networking related Assembly
class NetworkAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MoyaProvider<EHyundaiAppAPI>.self) { _ in
            MoyaProvider<EHyundaiAppAPI>()
        }
        container.register(MoyaProvider<HpointAPI>.self) { _ in
            MoyaProvider<HpointAPI>()
        }
    }
}

// Home related
class HomeAssembly: Assembly {
    func assemble(container: Container) {
        // Service
        container.register(HomeServiceProtocol.self) { r in
            HomeService()
        }.inObjectScope(.transient)
        
        // Repository
        container.register(HomeRepositoryInterface.self) { r in
            HomeRepository(homeService: r.resolve(HomeServiceProtocol.self)!)
        }.inObjectScope(.transient)
        
        // Usecase
        container.register(HomeUseCaseProtocol.self) { r in
            HomeUseCase(homeRepository: r.resolve(HomeRepositoryInterface.self)!)
        }.inObjectScope(.transient)
        
        // ViewModel
        container.register(HomeViewModel.self) { r in
            HomeViewModel(homeUseCase: r.resolve(HomeUseCaseProtocol.self)! as! HomeUseCase)
        }.inObjectScope(.transient)
    }
}

// Culture Center related
class CultureCenterAssembly: Assembly {
    func assemble(container: Container) {
        // Service
        container.register(CultureServiceProtocol.self) { r in
            CultureService()
        }.inObjectScope(.transient)
        
        // Repository
        container.register(CultureRepositoryInterface.self) { r in
            CultureRepository(cultureService: r.resolve(CultureServiceProtocol.self)!)
        }.inObjectScope(.transient)
        
        // Usecase
        container.register(CultureUseCaseProtocol.self) { r in
            CultureUseCase(cultureRepository: r.resolve(CultureRepositoryInterface.self)!)
        }.inObjectScope(.transient)
        
        // ViewModel
        container.register(CultureCenterViewModel.self) { r in
            CultureCenterViewModel(cultureUseCase: r.resolve(CultureUseCaseProtocol.self)! as! CultureUseCase)
        }.inObjectScope(.transient)
    }
}

// Coupon related Assembly
class CouponAssembly: Assembly {
    func assemble(container: Container) {
        // Service
        container.register(CouponServiceProtocol.self) { r in
            CouponService()
        }.inObjectScope(.transient)
        
        // Repository
        container.register(CouponRepositoryInterface.self) { r in
            CouponRepository(couponService: r.resolve(CouponServiceProtocol.self)!)
        }.inObjectScope(.transient)
        
        // Usecase
        container.register(CouponUsecaseProtocol.self) { r in
            CouponUsecase(couponRepository: r.resolve(CouponRepositoryInterface.self)!)
        }.inObjectScope(.transient)
        
        // ViewModel
        container.register(CouponViewModel.self) { r in
            CouponViewModel(couponUsecase: r.resolve(CouponUsecaseProtocol.self)! as! CouponUsecase)
        }.inObjectScope(.transient)
    }
}

class DIContainer: ObservableObject {
    static let shared = DIContainer()
    let container: Container
    
    private init() {
        container = Container()
    }
    
    func registerDependencies() {
        // Register all Assemblies
        let assemblies: [Assembly] = [
            NetworkAssembly(),
            HomeAssembly(),
            CultureCenterAssembly(),
            CouponAssembly()
        ]
        
        // Execute Assemblies
        assemblies.forEach { $0.assemble(container: container) }
    }
    
    func resolve<T>(_ type: T.Type) -> T? {
        container.resolve(T.self)
    }
}
