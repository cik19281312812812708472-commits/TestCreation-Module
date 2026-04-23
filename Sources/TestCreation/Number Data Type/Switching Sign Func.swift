//
//  Switching Sign Func.swift
//  TestCreation
//
//  Created by  on 2026-04-21.
//





extension Number {
    
    
    public static prefix func - (number: Number) -> Number {
        
        var newNumber: Number = 0
        if number.sign == .positive {
             newNumber = Number(number.value, sign: .negative)
        } else {
             newNumber = Number(number.value, sign: .positive)
        }
        
        return newNumber
    }
    
    
}
