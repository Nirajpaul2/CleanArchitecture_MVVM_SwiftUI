# Clean Architecture
This project follows Clean Architecture principles to ensure a well-structured and maintainable codebase. It's designed to be compatible with both UIKit and SwiftUI, focusing on separation of concerns, testability, and modular development.

## Clean Architecture 주요 원칙
1. Dependency Inversion Principle (DIP)
High-level modules should not depend on low-level modules. Both should depend on abstractions. Abstractions should not depend on details, but details should depend on abstractions.
➡️ For example, implementations in the Domain Layer do not directly depend on outer layers. Instead, dependencies are inverted through protocols (e.g., repository interfaces), which keeps business logic isolated from infrastructure details.

2. Separation of Boundaries
The software system is divided into distinct layers (or zones), with well-defined boundaries.
➡️ Each layer should be independently developable, testable, and modifiable, and should interact with others only through interfaces.

3. Interface Segregation Principle (ISP)
Clients should not be forced to depend on methods they do not use.
➡️ Instead of one large interface, create smaller, more specific ones.


Project Architecture Overview

  ./CleanArchitecture
  ├── Application
  │   ├── AppDelegate.swift
  │   ├── SceneDelegate.swift
  │   └── ViewControllerFactory.swift
  ├── Core
  │   ├── Dependency
  │   │   └── DIContainer.swift
  │   ├── Navigation
  │   │   ├── AppRouter.swift
  │   │   ├── CouponRoute.swift
  │   │   ├── CultureCenterRoute.swift
  │   │   ├── CustomNavigationContainer.swift
  │   │   ├── HomeRoute.swift
  │   │   └── NavigationProtocol.swift
  │   └── Util
  │       └── StringExtension.swift
  ├── Data
  │   ├── Model
  │   │   ├── Coupon
  │   │   ├── CultureCenter
  │   │   ├── Home
  │   │   └── bridge
  │   ├── Network
  │   │   ├── API
  │   │   ├── Common
  │   │   ├── Config
  │   │   ├── Foundation
  │   │   └── Service
  │   ├── Repository
  │   │   ├── Coupon
  │   │   ├── CultureCenter
  │   │   ├── DefaultCultureSearchResultRepository.swift
  │   │   └── HomeRepository.swift
  │   └── Transform
  │       └── HomeTransform.swift
  ├── Domain
  │   ├── Entity
  │   │   ├── Coupon
  │   │   ├── CultureLecture.swift
  │   │   ├── FoodBanner.swift
  │   │   └── HomeEntity.swift
  │   ├── Interface
  │   │   ├── CultureSearchResultRepository.swift
  │   │   └── HomeRepositoryInterface.swift
  │   └── UseCase
  │       ├── CouponUsecase.swift
  │       ├── CultureSearchListUseCase.swift
  │       └── HomeUseCase.swift
  ├── Global
  │   ├── Resources
  │   │   └── Assets.xcassets
  │   └── SupportingFiles
  │       ├── Base.lproj
  │       └── Info.plist
  └── Presentation
      ├── Common
      │   ├── Button
      │   ├── CustomNavigationBar.swift
      │   ├── NavigationTitle.swift
      │   └── ToastView.swift
      ├── Coupon
      │   ├── Screen
      │   ├── ViewModel
      │   └── Views
      ├── CultureCenter
      │   ├── View
      │   ├── ViewController
      │   ├── ViewModel
      │   └── CultureCenterWrapper.swift
      ├── Home
      │   ├── HomeScreen.swift
      │   └── HomeViewModel.swift
      ├── MainTab
      │   ├── MainTabType.swift
      │   └── MainTabViewController.swift
      ├── WebView
      │   └── BaseWebView.swift
      └── base
          ├── Intro.storyboard
          └── IntroViewController.swift


🧰 Used Technologies
Architecture: Clean Architecture

Frameworks & Reactive Programming: SwiftUI + Combine

Design Pattern: MVVM

Code Convention: SwiftLint

Build Configuration: Separate for Development, Staging, and Production

