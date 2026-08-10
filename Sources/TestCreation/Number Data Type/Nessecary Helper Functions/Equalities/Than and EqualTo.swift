//
//  GreaterThanEqualTo.swift
//  TestCreation
//
//  Created by Desire on 2026-08-09.
//

extension Number {
    
    
    static func >= (lhs: Number, rhs: Number) -> Bool {
        
        guard lhs > rhs else {
            return false
        }
        
        guard lhs == rhs else {
            return false
        }
        
        return true
    }
    
    
    static func <= (lhs: Number, rhs: Number) -> Bool {
        
        if lhs > rhs {
            return false
        }

        if lhs != rhs {
            return false
        }
        
        return true
    }
    
}
