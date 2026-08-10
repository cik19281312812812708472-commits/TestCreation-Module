//
//  Multiplication Function.swift
//  TestCreation
//
//  Created by  on 2026-04-21.
//

import Foundation

extension Number {
    
    
    //MARK: half made multiplication
    ///This function multiplies by the same way it is done by hand
    public static func * (lhs: Number, rhs: Number) -> Number {
        
        //old func stuff:
        /*
        let finalOutputValue = (Int(lhs.value) ?? 0) * (Int(rhs.value) ?? 0)
        var finalOutput: Number = Number(finalOutputValue)
         */
        
        var finalOutput: Number = 0
        
        let signMultiplant: Int = lhs.sign == .negative || rhs.sign == .negative ? -1 : 1
        
        let leftNumber: reversedNumber = reverseNumber(lhs)
        
        let leftNumberAboveDecimal: [Character] = leftNumber.partAboveDecimal
        let leftNumberBelowDecimal: [Character] = leftNumber.partBelowDecimal
        
        let trueLeftNum = leftNumberBelowDecimal + leftNumberAboveDecimal
        
        let rightNumber: reversedNumber = reverseNumber(rhs)
        
        
        let rightNumberAboveDecimal: [Character] = rightNumber.partAboveDecimal
        let rightNumberBelowDecimal: [Character] = rightNumber.partBelowDecimal
        
        let trueRightNum = rightNumberBelowDecimal + rightNumberAboveDecimal
        
        //multiplying each num
        var allStuffToAdd: [Number] = []
        for j in 0..<trueRightNum.count {
            
            let number = trueRightNum[j]
            
            var stuffToAdd: [Number] = []
            for i in 0..<trueLeftNum.count {
                
                
                let firstFactor: Int = number.wholeNumberValue ?? 0
                let secondFactor: Int = trueLeftNum[i].wholeNumberValue ?? 0
             
              
                
              
                
                
                //what if the power is greater the the double limit? i need to create my own 10 power func that doesn't use int nor double
                
                //this can never too big.
                let newNumber: Int = firstFactor * secondFactor
                
                let power = j + i
                
                
                
                let trueNewNum: Number = Number(pow10(String(newNumber), times: power))
                
                stuffToAdd.append(trueNewNum)
                
            }
            
            //now we add every number by converting it to a number struct incase it is very big
            var finalNumber: Number = 0
            
            for i in 0..<stuffToAdd.count {
                
                let numberToAdd: Number = stuffToAdd[i]
                finalNumber += numberToAdd
                
                
            }
            allStuffToAdd.append(finalNumber)
            
        }
        
        //MARK: add the decimal putting
        //wdym
        //Now we add all the results
        var finalNumber: Number = 0
        for i in 0..<allStuffToAdd.count {
            finalNumber += allStuffToAdd[i]
        }
       
        if signMultiplant == -1 {
            finalNumber = -finalNumber
        } else {
          //what if final num is negativ?
        }
        
        
        
        
        finalOutput = finalNumber
        
        return finalOutput
    }
    
}
