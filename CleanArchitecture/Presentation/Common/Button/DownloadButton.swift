//
//  DownloadButton.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 3/8/25.
//

import Foundation
import SwiftUI

struct DownloadButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: "arrow.down.circle")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.indigo)
        }
        .buttonStyle(PlainButtonStyle())
        .contentShape(Rectangle())
    }
}
