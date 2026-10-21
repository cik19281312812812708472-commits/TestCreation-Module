//
//  PythonRunner.swift
//  TestCreation
//
//  Created by Desire on 2026-10-21.
//


import Foundation
import PythonKit

public enum PythonRunner {
    
    public static func evaluateScript(code: String) -> String {
        PythonEnvironment.initialize()

        let builtins = Python.import("builtins")
        
        // Execute raw Python code string
      
        
        
        let result = builtins.eval(code)
        
        return "Sum of squares: \(result)"
    }
}
