//
//  BaseWebView.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 3/8/25.
//

import SwiftUI
import WebKit

// Screen that wraps the WebView
struct BaseWebView: View {
    let url: String
    let navTitle: String
    
    var body: some View {
        VStack {
            CustomNavigationBar(title: navTitle)
            if let url = URL(string: url) {
                WebViewWrapper(url: url)
                    .navigationBarHidden(true)  // Hide default navigation bar
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}
