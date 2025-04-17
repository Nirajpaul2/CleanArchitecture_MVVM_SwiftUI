//
//  CultureCenterWrapper.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 1/18/25.
//

import SwiftUI
import UIKit

struct LectureResultViewWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> LectureResultViewController {
        // Resolving CultureCenterViewModel from DI container
        let cultureViewModel = DIContainer.shared.resolve(CultureCenterViewModel.self)!
        let vc = LectureResultViewController(cultureCenterViewModel: cultureViewModel)
        return vc
    }

    func updateUIViewController(_ uiViewController: LectureResultViewController, context: Context) {
        // Add update logic here if needed
    }
}
