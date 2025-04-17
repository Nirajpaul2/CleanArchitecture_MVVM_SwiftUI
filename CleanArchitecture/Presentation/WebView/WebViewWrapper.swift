//
//  WebViewWrapper.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 3/2/25.
//

import SwiftUI
import WebKit

struct WebViewWrapper: UIViewRepresentable {
    @EnvironmentObject private var router: AppRouter
    let url: URL
    private let CONFIG_WEB_NAME = "callAppNative"
    
    func makeUIView(context: Context) -> WKWebView { // Settings for the webview
        let webView = WKWebView(frame: .zero, configuration: makeConfiguration())
        
        // Connect Router via DI (Dependency Injection)
        BridgeManager.shared.setRouter(router)
        
        webView.configuration.userContentController.add(WebViewContentController(), name: CONFIG_WEB_NAME) // Register Javascript ↔ Native handler
        
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) { // Update UI for webview
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    private func makeConfiguration() -> WKWebViewConfiguration {
        let configuration = WKWebViewConfiguration()
        configuration.preferences.setValue(true, forKey: "developerExtrasEnabled") // Enable developer tools
        return configuration
    }
}
