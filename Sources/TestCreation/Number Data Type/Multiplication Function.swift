//
//  Multiplication Function.swift
//  TestCreation
//
//  Created by Desire on 2026-04-21.
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
        
        var leftNumber: reversedNumber = reverseNumber(lhs)
        
        var leftNumberAboveDecimal: [Character] = leftNumber.partAboveDecimal
        var leftNumberBelowDecimal: [Character] = leftNumber.partBelowDecimal
        
        var trueLeftNum = leftNumberBelowDecimal + leftNumberAboveDecimal
        
        var rightNumber: reversedNumber = reverseNumber(rhs)
        
        
        var rightNumberAboveDecimal: [Character] = rightNumber.partAboveDecimal
        var rightNumberBelowDecimal: [Character] = rightNumber.partBelowDecimal
        
        var trueRightNum = rightNumberBelowDecimal + rightNumberAboveDecimal
        
        //multiplying each num
        var allStuffToAdd: [Number] = []
        for j in 0..<trueRightNum.count {
            
            let number = trueRightNum[j]
            
            var stuffToAdd: [Int] = []
            for i in 0..<trueLeftNum.count {
                
                
                let firstFactor: Int = number.wholeNumberValue ?? 0
                let secondFactor: Int = trueLeftNum[i].wholeNumberValue ?? 0
             
              
                
                let power = j + i
                
                
                
                //this canot be very big so we can add it normally
                let newNumber: Int = firstFactor * secondFactor * Int(pow(Double(10), Double(power+1)))
                
                
                stuffToAdd.append(newNumber)
                
            }
            
            //now we add every number by converting it to a number struct incase it is very big
            var finalNumber: Number = 0
            
            for i in 0..<stuffToAdd.count {
                
                let numberToAdd: Number = Number(stuffToAdd[i])
                finalNumber += numberToAdd
                
            }
            allStuffToAdd.append(finalNumber)
            
        }
        
        //MARK: add the decimal putting
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
