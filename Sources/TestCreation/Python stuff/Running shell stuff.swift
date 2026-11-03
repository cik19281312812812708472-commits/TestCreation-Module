//
//  Running shell stuff.swift
//  TestCreation
//
//  Created by Desire on 2026-11-02.
//

import Foundation

///temp should be "-c" or "-ic"
func shell(_ temp: String, _ command: String) -> String {
    let process = Process()
    let pipe = Pipe()
    
    // Configure the environment and process
    process.standardOutput = pipe
    process.standardError = pipe
    process.arguments = [temp, command]
    process.launchPath = "/bin/zsh" // Or "/bin/bash"
    
    do {
        
        try process.run() // Use process.launch() if targeting macOS 13 or older
        process.waitUntilExit()
    } catch {
        return "Error executing command: \(error.localizedDescription)"
    }
    
    // Read the binary data from the pipe and convert it to a String
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    if let output = String(data: data, encoding: .utf8) {
        return output
    }
    
    return ""
}
