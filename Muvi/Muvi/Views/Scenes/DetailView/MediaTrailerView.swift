//
//  MediaTrailerView.swift
//  Muvi
//
//  Created by Atakan Atalar on 5.09.2024.
//

import SwiftUI
import WebKit

struct MediaTrailerView: View {
    @Environment(\.dismiss) private var dismiss
    let mediaTrailerId: String
    
    var body: some View {
        NavigationStack {
            WKWebViewRepresentable(videoId: mediaTrailerId)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    MediaTrailerView(mediaTrailerId: "")
}

struct WKWebViewRepresentable: UIViewRepresentable {
    let videoId: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let embedURL = "https://www.youtube.com/embed/\(videoId)?autoplay=1"
        guard let url = URL(string: embedURL) else { return }
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WKWebViewRepresentable
        
        init(_ parent: WKWebViewRepresentable) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            let js = "document.querySelector('video').play()"
            webView.evaluateJavaScript(js, completionHandler: nil)
        }
    }
}
