//
//  Converting Binary.swift
//  TestCreation
//
//  Created by Desire on 2026-08-09.
//



extension Number {
    
    ///This does not work for decimal binary (please add a division function.)
    static func convertBinaryToNumber(binary: [Int], belowDecimalBinary: [Int]) -> Number {
        
        
        
        
        var aboveDecimalNumber: Number = 0
        let binaryCount = binary.count
        
        for i in 1...binary.count {
            ///i starts at 1 as we are looking at the binary in reverse. However, i still represents the power of 2 so it must start at zero hence the - 1
            let binaryDigit = binary[binaryCount - i]
            
            if binaryDigit == 1 {
                print("2^\(i - 1)" )
                let numToAdd = intPow(lhs: Number(2), rhs: Number(i - 1)) //returns 2
                aboveDecimalNumber += numToAdd
            }
            
            
        }
        
        let belowDecimalNumber: Number = 0
        
        let belowDecimalBinaryCount = belowDecimalBinary.count
        
        for i in 1...belowDecimalBinary.count {
            
            let binaryDigit = binary[belowDecimalBinaryCount - i]
            
            if binaryDigit == 1 {
                
                let numToAdd: Number = 0 //Number(1) / intPow(lhs: Number(2), rhs: Number(i))
                aboveDecimalNumber += numToAdd
            }
            
            
        }
        
        
        return (aboveDecimalNumber + belowDecimalNumber)
    }
    
}
