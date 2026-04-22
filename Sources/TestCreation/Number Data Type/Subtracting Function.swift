//
//  Subtracting Function.swift
//  TestCreation
//
//  Created by Desire on 2026-04-21.
//


extension Number {
    
    public static func - (lhs: Number, rhs: Number) -> Number {
    
        var finalOutput: Number = 0
        //we dont subtract when both are negative
        if rhs.sign == .negative {
            
        } else {
            //the $0 is each element in a loop
            var leftNum: [Character] = Array(lhs.value.reversed())
            var parts: [Array<Character>.SubSequence] = (leftNum.split { $0 == "."}).reversed()
            print("parts: ", parts)
            let leftNumAboveDecimal: [Character] = Array(parts[0])
            var leftNumBelowDecimal: [Character] = []
            
            if parts.count > 1 {
                leftNumBelowDecimal = Array(parts[1])
            }
            
            
            
            var rightNum: [Character] = Array(rhs.value.reversed())
            parts = (rightNum.split { $0 == "."}).reversed()
            
            let rightNumAboveDecimal: [Character] = Array(parts[0])
            var rightNumBelowDecimal: [Character] = []
            
            if parts.count > 1 {
                rightNumBelowDecimal = Array(parts[1])
            }
            
            //for if 1 number is larger than the other
            var repeatingTimes = leftNumAboveDecimal.count
            
            
            
            
            var newValueAboveDecimal: [Character] = []
            
            //first do the above decimal so that if the decimal rouds up we just havethe change the aleardy made value instead of carrying
            var carry: Int = 0
            
            
            
            var newValueBelowDecimal: [Character] = []
            
            repeatingTimes = leftNumBelowDecimal.count > rightNumBelowDecimal.count ?  leftNumBelowDecimal.count : rightNumBelowDecimal.count
            
            carry = 0
            
            
            
            
            
            
            
            
            
            
            var tempFinalOutput: String = ""
            newValueAboveDecimal = newValueAboveDecimal.reversed()
            for i in newValueAboveDecimal {
                tempFinalOutput += String(i)
            }
            
            
            if newValueBelowDecimal.count > 0 {
                tempFinalOutput += "."
                newValueBelowDecimal = newValueBelowDecimal.reversed()
                for i in newValueBelowDecimal {
                    tempFinalOutput += String(i)
                }
            }
            finalOutput = Number(tempFinalOutput)
        }
        
        return finalOutput
        
       
    }
    
    
    
    
}
