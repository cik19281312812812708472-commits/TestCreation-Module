//
//  Less Than.swift
//  TestCreation
//
//  Created by Desire on 2026-08-09.
//

extension Number {
    
    public static func < (lhs: Number, rhs: Number) -> Bool {
        
        if lhs == rhs {
            return false
        } else {
            
            let bool = (lhs > rhs)
            print("is lhs: ", lhs, " Greater than ", rhs, " ? ", bool)
            
            if bool == true {
                return false
            } else {
                return true
            }
            
        }
        
    }
    
    
}
