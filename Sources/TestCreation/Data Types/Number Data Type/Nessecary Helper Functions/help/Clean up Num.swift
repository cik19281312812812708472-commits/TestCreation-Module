//
//  Clean up Num.swift
//  TestCreation
//
//  Created by Desire on 2026-08-10.
//

extension Number {
    
    
    ///This function helps remove any bugginess that might come with some numbers.
    public mutating func cleanUp() {
        
        
        let temp = self
        
        let tempReversed = reverseNumber(temp)
        
        var valueAbove = tempReversed.partAboveDecimal
        let valueBelow = tempReversed.partBelowDecimal
        
        let item = valueAbove[0]
        var finalNumber = ""
        
        if item == "0" && finalNumber.count > 1 {
           valueAbove = Array(valueAbove.dropFirst(1))
            
            for i in 0..<valueAbove.count {
                
            }
        }
        
        
        
        for i in 0..<valueAbove.count {
            
            let item = valueAbove[i]
            finalNumber += String(item)
           
        }
        
        if valueBelow.count > 0 {
            finalNumber += "."
            
            
            for i in 0..<valueBelow.count {
                
                let item = valueBelow[i]
                finalNumber += String(item)
                
            }
        }
        
        self = Number(finalNumber, sign: self.sign)
        
        
    }
    
    
    
}
