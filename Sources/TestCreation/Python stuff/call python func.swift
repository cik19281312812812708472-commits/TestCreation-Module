//
//  calloython func.swift
//  TestCreation
//
//  Created by Desire on 2026-10-30.
//

import Foundation

///Add the arguments that you want to be added to python e.g: python3.12 + arguments.
///the process name gets printed out
///returns the output
public func callPython(arguments: [String] = [], proccessName: String) -> String {
    let process = Process()
    let pipe = Pipe()
    
    // Use python3 to invoke pip securely
    let pythonLibPath = String(cString: getenv("PYTHON_LIBRARY"))
    
    process.executableURL = URL(fileURLWithPath: pythonLibPath)
    // If python3 is elsewhere, you can use "/usr/bin/env" and pass ["python3", "-m", "pip", ...]
    process.arguments = arguments
    
    // Hook up the pipe to capture standard output and standard error
    process.standardOutput = pipe
    process.standardError = pipe
    
    do {
        print(proccessName)
        try process.run()
        
        // Read the output stream as it installs
        let fileHandle = pipe.fileHandleForReading
        let data = fileHandle.readDataToEndOfFile()
        
        process.waitUntilExit()
        
        if let output = String(data: data, encoding: .utf8) {
           return output
        }
        
        // Check if it exited successfully (status 0)
        let success = process.terminationStatus == 0
        
        if success {
            print("Successful!")
        } else {
            print("Failed with exit code: \(process.terminationStatus)")
        }
        UserDefaults.standard.set(true, forKey: "installedSentenceTransformers")
        
        return ""
        
    } catch {
        print("Failed to start pip process: \(error)")
        return ""
    }
}
