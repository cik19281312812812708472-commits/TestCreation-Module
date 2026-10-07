//
//  QuestionContent.swift
//  TestCreation
//
//  Created by Desire on 2026-10-04.
//


@available(macOS 10.15, iOS 13, *)
public struct QuestionContent: View {

    //type eraser
    public var content: AnyView
    
    //For working with web view:
    public var contentFileURL: URL? = nil
    public var contentHTMLFileName: String? = nil
    
    public init(_ content: AnyView) {

        self.content = content

    }

    public init<V: View>(@ViewBuilder builder: () -> V) {

        self.content = AnyView(builder())

    }
    
    public init(_ contentFileURL: URL, HTMLFileName: String) {
        self.content = AnyView(LocalCrossPlatformWebView(fileDirectory: contentFileURL, HTMLFileName: HTMLFileName))
        self.contentFileURL = contentFileURL
        self.contentHTMLFileName = HTMLFileName 
    }
    
    public var body: some View {

        content

    }

    
}
