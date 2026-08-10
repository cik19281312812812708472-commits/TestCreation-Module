//
//  Low Level x10 multiplication.swift
//  TestCreation
//
//  Created by Desire on 2026-04-23.
//

extension Number {
    
    ///This SHOULD NEVER USE DECIMAL NUMBERS
    static func pow10(_ what: String, times: Int) -> String {
        
        var arrayWhat: [Character] = Array(what)
        
        for i in 0..<times {
            
            arrayWhat.append("0")
            
        }
        
        
        var result: String = ""
        
        for i in arrayWhat {
            
            result.append(i)
            
      
        }
        
        
        return result
    }
    
    
    
}
