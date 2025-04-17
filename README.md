# Medium Article link
https://nirajpaul2.medium.com/mvvm-architecture-103af2497b5a

# Clean Architecture
This project follows Clean Architecture principles to ensure a well-structured and maintainable codebase. It's designed to be compatible with both UIKit and SwiftUI, focusing on separation of concerns, testability, and modular development.

## Clean Architecture
1. Dependency Inversion Principle (DIP)
High-level modules should not depend on low-level modules. Both should depend on abstractions. Abstractions should not depend on details, but details should depend on abstractions.
➡️ For example, implementations in the Domain Layer do not directly depend on outer layers. Instead, dependencies are inverted through protocols (e.g., repository interfaces), which keeps business logic isolated from infrastructure details.

2. Separation of Boundaries
The software system is divided into distinct layers (or zones), with well-defined boundaries.
➡️ Each layer should be independently developable, testable, and modifiable, and should interact with others only through interfaces.

3. Interface Segregation Principle (ISP)
Clients should not be forced to depend on methods they do not use.
➡️ Instead of one large interface, create smaller, more specific ones.


<details>
  <summary>Project Tree Structure</summary>
  
  ```
  ./CleanArchitecture
├── Application                # App entry points and setup
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   └── ViewControllerFactory.swift
│
├── Core                      # Shared infrastructure
│   ├── Dependency
│   │   └── DIContainer.swift    # Dependency injection (Swinject)
│   ├── Navigation
│   │   ├── AppRouter.swift      # Root navigation logic
│   │   ├── CouponRoute.swift    # Coupon navigation routes
│   │   ├── CultureCenterRoute.swift
│   │   ├── CustomNavigationContainer.swift  # SwiftUI navigation wrapper
│   │   └── NavigationProtocol.swift
│   └── Util
│       └── StringExtension.swift
│
├── Data                      # Data Layer
│   ├── Network
│   │   ├── API                 # Moya API definitions (TargetType)
│   │   ├── Service            # Network service implementations
│   │   └── MoyaProvider.swift # Moya configuration
│   ├── Repository
│   │   ├── Coupon             # Coupon repository implementation
│   │   ├── CultureCenter      # CultureCenter repository impl.
│   │   └── HomeRepository.swift
│   ├── Model
│   │   ├── DTO                # Data Transfer Objects (API responses)
│   │   │   ├── CouponDTO.swift
│   │   │   └── HomeDTO.swift
│   │   └── Bridge             # JS ↔ Native bridge logic
│   └── Transform
│       └── HomeTransform.swift # DTO → Entity mapping
│
├── Domain                    # Domain Layer (Business Logic)
│   ├── Entity
│   │   ├── Coupon             # Domain entities (pure business models)
│   │   ├── CultureLecture.swift
│   │   └── HomeEntity.swift
│   ├── UseCase
│   │   ├── CouponUseCase.swift   # Business logic for coupons
│   │   ├── CultureSearchListUseCase.swift
│   │   └── HomeUseCase.swift
│   └── Interface
│       ├── CouponRepositoryInterface.swift # Data access contracts
│       └── HomeRepositoryInterface.swift
│
├── Presentation              # Presentation Layer (UI)
│   ├── Common                # Shared UI components
│   │   ├── CustomNavigationBar.swift
│   │   ├── ToastView.swift
│   │   └── Button
│   ├── Coupon                # Coupon feature
│   │   ├── Screen            # SwiftUI/UIKit screens
│   │   ├── ViewModel         # CouponViewModel
│   │   └── Views             # Subviews (e.g., CouponListView)
│   ├── CultureCenter         # CultureCenter feature
│   │   ├── View
│   │   ├── ViewModel
│   │   └── CultureCenterWrapper.swift
│   ├── Home                  # Home feature
│   │   ├── HomeScreen.swift
│   │   └── HomeViewModel.swift
│   ├── MainTab               # Tab navigation
│   │   ├── MainTabType.swift
│   │   └── MainTabViewController.swift
│   └── WebView
│       └── BaseWebView.swift # WebView wrapper (SwiftUI/UIKit)
│
├── Global                    # Resources & config
│   ├── Resources
│   │   └── Assets.xcassets   # Images, colors, etc.
│   └── SupportingFiles
│       ├── Info.plist
│       └── Base.lproj        # Localization
│
└── base                      # Intro/launch screen
    ├── Intro.storyboard
    └── IntroViewController.swift
  ```
</details>


🧰 Used Technologies

Architecture: Clean Architecture

Frameworks & Reactive Programming: SwiftUI + Combine

Design Pattern: MVVM

Code Convention: SwiftLint

Build Configuration: Separate for Development, Staging, and Production

