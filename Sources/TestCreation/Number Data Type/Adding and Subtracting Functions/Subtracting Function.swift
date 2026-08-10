//
//  Subtracting Function.swift
//  TestCreation
//
//  Created by  on 2026-04-21.
//


extension Number {
    
    
    ///Decimals dont work for now
    public static func - (lhs: Number, rhs: Number) -> Number {
       // print("Subtracting: ", lhs, " by ", rhs)
        var finalOutput: Number = 0
        
        if lhs.sign == .negative && lhs.sign == rhs.sign {
            
            let tempLhs = -lhs
            let tempRhs = -rhs
            
            return tempLhs - tempRhs
            
            
        }
        
        //the not equal equality has alreadly been done as it has to be not equal to get here
        if lhs.sign == .negative && rhs.sign == .positive {
        
            let temp = lhs + rhs
            
            return -temp
            
        }
        //if the rhs is negative
        if lhs.sign == .positive && rhs.sign == .negative {
            
            return lhs + rhs
        }
        
        //Now we have our ideal subtraction situation (except 1 thing)
       // print("here3")
        //the $0 is each element in a loop
        let leftNum: [Character] = Array(lhs.value.reversed())
        var parts: [Array<Character>.SubSequence] = (leftNum.split { $0 == "."}).reversed()
       // print("parts: ", parts)
        
        var finalOutputIsNegative = false
        var leftNumAboveDecimal: [Character] = Array(parts[0])
        var leftNumBelowDecimal: [Character] = []
      // leftNumAboveDecimal = leftNumAboveDecimal.reversed()
        if parts.count > 1 {
            leftNumBelowDecimal = Array(parts[1])
        }
        
        let rightNum: [Character] = Array(rhs.value.reversed())
        parts = (rightNum.split { $0 == "."}).reversed()
        
        let rightNumAboveDecimal: [Character] = Array(parts[0])
        var rightNumBelowDecimal: [Character] = []
        
        if parts.count > 1 {
            rightNumBelowDecimal = Array(parts[1])
        }
        
        var leftNumAboveDecimalIsGreaterThanRightNumAboveDecimal = leftNumAboveDecimal.count >= rightNumAboveDecimal.count ? true : false
        
        //first do the above decimal so we can carry roundings into
        var carry: Int = 0
        
        var newValueBelowDecimal: [Character] = []
        var newValueAboveDecimal: String = ""
        var tempFinalOutput: String = "0"
        
        var whatToDoEachTime: (Int, Int, Int) -> () = { leftNumDigit, rightNumDigit, index in
           
            let result = leftNumDigit - rightNumDigit
          //  print("Subtracting Digits: ", leftNumDigit, " by ", rightNumDigit)
           // print("result: ", result)
            carry = 0
            
            if result == 0 && carry == 0 && index == leftNumAboveDecimal.count - 1  && leftNumAboveDecimal.count != 1 {
                return 
            }
            
            if result < 0 {
                
                
               // print("index: ", index)
                if index == leftNumAboveDecimal.count - 1 {
                    newValueAboveDecimal += String(-result)
                    finalOutputIsNegative = true
                } else {
                    carry -= 1
                    
                    let temp = 10 + result//result is negative
                    
                   // print("temp: ", temp)
                    newValueAboveDecimal += String(temp)
                }
                
            } else {
                newValueAboveDecimal += String(result)
            }
            
            
            
        }
        
        if leftNumAboveDecimalIsGreaterThanRightNumAboveDecimal {
            
            let rightNumAboveDecimalCount = rightNumAboveDecimal.count
            
            for i in 0..<leftNumAboveDecimal.count {
                
                let leftNumDigit = Int(String(leftNumAboveDecimal[i])) ?? 0
                
                if rightNumAboveDecimalCount - i <= 0 {
                    
                    whatToDoEachTime(leftNumDigit + carry, 0, i)
                } else {
                    whatToDoEachTime(leftNumDigit + carry, Int(String(rightNumAboveDecimal[i])) ?? 0, i)
                }
                
                
                
                
                
            }
            
        } else {
            return -(rhs - lhs)
        }
        
        tempFinalOutput = newValueAboveDecimal
        if newValueBelowDecimal.count > 0 {
            tempFinalOutput += "."
           // newValueBelowDecimal = newValueBelowDecimal.reversed()
            for i in newValueBelowDecimal {
                tempFinalOutput += String(i)
            }
        }
        
        
        finalOutput = Number(tempFinalOutput)
        if finalOutputIsNegative {
            finalOutput = -finalOutput
        }
        
        finalOutput.cleanUp()
       // print("final output: ", finalOutput)
        return finalOutput
        
        
    }
    
    
    
    
}
