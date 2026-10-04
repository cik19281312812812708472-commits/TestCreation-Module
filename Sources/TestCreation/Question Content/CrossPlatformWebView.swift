//
//  CrossPlatformWebView.swift
//  TestCreation
//
//  Created by Desire on 2026-10-04.
//

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
