//
//  Exponentiation.swift
//  TestCreation
//
//  Created by Desire on 2026-08-09.
//

extension Number {
    
    ///This only works for whole numbers, for now
    public static func intPow(lhs: Number, rhs: Number) -> Number {
        
        
        var counter = rhs
       
        let temp = lhs
        
        var result = Number(1)
       
        while true {
            
            //it fails to compare
            if counter <= Number(0) {
                return result
            }
            
            
            result = result * temp
            print("counter: ", counter)
            counter -= Number(1)
        }
        
    }
    
    
}
