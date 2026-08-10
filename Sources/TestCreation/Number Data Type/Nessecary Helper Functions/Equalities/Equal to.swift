//
//  Equal to.swift
//  TestCreation
//
//  Created by Desire on 2026-08-09.
//

extension Number {
    
    
    public static func == (lhs: Number, rhs: Number) -> Bool {
        
        guard lhs.sign == rhs.sign else {
            return false
        }
        
        //because it might have a decimal of 0 lets do this:
        
        let leftNum = reverseNumber(lhs)
        let rightNum = reverseNumber(rhs)
        
        let leftNumAboveDecimal = leftNum.partAboveDecimal
        let rightNumAboveDecimal = rightNum.partAboveDecimal
        
        let leftNumBelowDecimal = leftNum.partBelowDecimal
        
        let rightNumBelowDecimal = rightNum.partBelowDecimal
        
        //print("lhs: ", lhs)
       // print("rhs: ", rhs)
        // print("l1", leftNumAboveDecimal, "l2", leftNumBelowDecimal, "r1", rightNumAboveDecimal, "r2", rightNumBelowDecimal)
        //print(leftNumAboveDecimal == rightNumAboveDecimal)
        
        guard leftNumAboveDecimal == rightNumAboveDecimal else {
            return false
        }
        
        guard leftNumBelowDecimal == rightNumBelowDecimal else {
            return false
        }
        
        return true
    }
    
    
    public static func != (lhs: Number, rhs: Number) -> Bool {
        
        let bool = lhs == rhs
        
        return !bool
        
    }
    
    
    
}
