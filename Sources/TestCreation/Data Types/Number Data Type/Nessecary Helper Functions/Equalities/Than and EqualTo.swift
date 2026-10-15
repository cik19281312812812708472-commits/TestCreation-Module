//
//  GreaterThanEqualTo.swift
//  TestCreation
//
//  Created by Desire on 2026-08-09.
//

extension Number {
    
    
    public static func >= (lhs: Number, rhs: Number) -> Bool {
        
        guard lhs > rhs else {
            return false
        }
        
        guard lhs == rhs else {
            return false
        }
        
        return true
    }
    
    
    public static func <= (lhs: Number, rhs: Number) -> Bool {
        
        if lhs > rhs {
            return false
        }

        if lhs != rhs {
            return false
        }
        
        return true
    }
    
}
