//
//  Printing Extension.swift
//  TestCreation
//
//  Created by  on 2026-04-22.
//

extension Number: CustomStringConvertible {
    
    public var description: String {
        
        var prefix: String = ""
        
        if sign == .negative {
            prefix = "-"
        }
        
        return "\(prefix)\(value)"
        
    }
    
    
    
    
}
