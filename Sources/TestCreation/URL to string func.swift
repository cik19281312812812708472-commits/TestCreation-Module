//
//  URL to string func.swift
//  TestCreation
//
//  Created by Desire on 2026-10-30.
//


//
//  convertingURLtoString.swift
//  WiseGPT
//
//  Created by Desire on 2026-10-28.
//

import Foundation

public extension URL {
    static func toString(_ url: URL) -> String? {
        if #available(macOS 13.0, *) {
            guard let decodedPath = url.path().removingPercentEncoding else {
                print("Failed to decode path")
                return nil
            }
            return decodedPath
        } else {
            let decodedPath = url.path
            return decodedPath
            // Fallback on earlier versions
        }
        
        
      
    }
}
