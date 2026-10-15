//
//  CrossPlatformWebView.swift
//  TestCreation
//
//  Created by Desire on 2026-10-04.
//
import SwiftUI
import WebKit
#if os(macOS)
typealias RepresentableContext = NSViewRepresentableContext<LocalCrossPlatformWebView>
typealias ViewRepresentable = NSViewRepresentable
import AppKit
#else
typealias RepresentableContext = UIViewRepresentableContext<LocalCrossPlatformWebView>
typealias ViewRepresentable = UIViewRepresentable
import UIKit
#endif

struct LocalCrossPlatformWebView: ViewRepresentable {
    let fileDirectory: URL
    let HTMLFileName: String

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: LocalCrossPlatformWebView
        var loadedURL: URL?

        init(_ parent: LocalCrossPlatformWebView) {
            self.parent = parent
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    private func createConfiguredWebView() -> WKWebView {
        let configuration = WKWebViewConfiguration()
        // Allow access to local file URLs in WKWebView
        configuration.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        return WKWebView(frame: .zero, configuration: configuration)
    }

    private func loadFile(in webView: WKWebView) {
        let fileURL = fileDirectory.appendingPathComponent(HTMLFileName)
        
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            print("File not found at path: \(fileURL.path)")
            return
        }
        
        // Grant access to the parent directory containing HTML/CSS/JS resources
        webView.loadFileURL(fileURL, allowingReadAccessTo: fileDirectory)
    }

    #if os(macOS)
    func makeNSView(context: Context) -> WKWebView {
        let webView = createConfiguredWebView()
        webView.navigationDelegate = context.coordinator
        loadFile(in: webView)
        context.coordinator.loadedURL = fileDirectory.appendingPathComponent(HTMLFileName)
        return webView
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
        let targetURL = fileDirectory.appendingPathComponent(HTMLFileName)
        // Only reload if the target file directory or name actually changed
        if context.coordinator.loadedURL != targetURL {
            context.coordinator.loadedURL = targetURL
            loadFile(in: nsView)
        }
    }
    #else
    func makeUIView(context: Context) -> WKWebView {
        let webView = createConfiguredWebView()
        webView.navigationDelegate = context.coordinator
        loadFile(in: webView)
        context.coordinator.loadedURL = fileDirectory.appendingPathComponent(HTMLFileName)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let targetURL = fileDirectory.appendingPathComponent(HTMLFileName)
        if context.coordinator.loadedURL != targetURL {
            context.coordinator.loadedURL = targetURL
            loadFile(in: uiView)
        }
    }
    #endif
}

/*
import WebKit


#if os(macOS)
typealias RepresentableContext = NSViewRepresentableContext<LocalCrossPlatformWebView>
typealias ViewRepresentable = NSViewRepresentable
import AppKit
#else
typealias RepresentableContext = UIViewRepresentableContext<LocalCrossPlatformWebView>
typealias ViewRepresentable = UIViewRepresentable
import UIKit
#endif

struct LocalCrossPlatformWebView: ViewRepresentable {
    
    let fileDirectory: URL
    let HTMLFileName: String
    
   
    #if os(macOS)
    
    
    func makeNSView(context: RepresentableContext) -> WKWebView {
        
        WKWebView()
      
    }
    
    
    func updateNSView(_ nsView: WKWebView, context: RepresentableContext) {
        loadSavedLocalFile(in: nsView, directory: fileDirectory, fileName: HTMLFileName)
    }
    
    
    #else
    
    
    func makeUIView(context: RepresentableContext) -> WKWebView { WKWebView() }
    
    func updateUIView(_ uiView: WKWebView, context: RepresentableContext) {
        loadSavedLocalFile(in: uiView, directory: fileDirectory, fileName: HTMLFileName)
    }
    
    
    #endif
    
    
    
    func loadSavedLocalFile(in webView: WKWebView, directory: URL, fileName: String) {
        let fileManager = FileManager.default
        
        let fileURL = directory.appendingPathComponent(fileName)

        // Check if file exists before loading
        if fileManager.fileExists(atPath: fileURL.path) {
            // Grant access to the whole Documents directory so relative CSS/JS loads correctly
            webView.loadFileURL(fileURL, allowingReadAccessTo: directory)
        } else {
            print("File not found at path: \(fileURL.path)")
        }
        
    }
}
*/
