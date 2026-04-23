//
//  Adding function.swift
//  TestCreation
//
//  Created by  on 2026-04-21.
//



extension Number {
    
    //MARK: FIX THE SIGNING ISSUE 
    public static func + (lhs: Number, rhs: Number) -> Number {
        
        var finalOutput: Number = 0
        //we dont add when we it is negative
        if rhs.sign == .negative {
            
        } else {
            //the $0 is each element in a loop
            var leftNum: [Character] = Array(lhs.value.reversed())
            var parts: [Array<Character>.SubSequence] = (leftNum.split { $0 == "."}).reversed()
         //   print("parts: ", parts)
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
            for i in 0..<repeatingTimes {
                
                //the i< leftnum... is the conditional. the ? is the true and the : and rest is the false
                let leftNumCharcacter = i < leftNumBelowDecimal.count ? leftNumBelowDecimal[i] : "0"
                let addingLeftNum: Int = Int(String(leftNumCharcacter)) ?? 0
                
                let rightNumCharacter = i < rightNumBelowDecimal.count ? rightNumBelowDecimal[i] : "0"
                let addingRightNum: Int = Int(String(rightNumCharacter)) ?? 0
                
                var addedValue = addingLeftNum + addingRightNum
                addedValue += carry
                
                //carry handling
                let sum = addingLeftNum + addingRightNum + carry
                addedValue = sum % 10
                carry = sum / 10
                
                
                //print(addedValue)
                newValueBelowDecimal.append(Character(String(addedValue)))
              // print(newValueBelowDecimal)
            }
           // print("carry: ", carry)
            
            
            
            repeatingTimes = leftNumAboveDecimal.count > rightNumAboveDecimal.count ?  leftNumAboveDecimal.count : rightNumAboveDecimal.count
            
            
            for i in 0..<repeatingTimes {
                
                //the i< leftnum... is the conditional. the ? is the true and the : and rest is the false
                let leftNumCharcacter = i < leftNumAboveDecimal.count  ? leftNumAboveDecimal[i] : "0"
                let addingLeftNum: Int = Int(String(leftNumCharcacter)) ?? 0
                
                let rightNumCharacter = i < rightNumAboveDecimal.count ? rightNumAboveDecimal[i] : "0"
                let addingRightNum: Int = Int(String(rightNumCharacter)) ?? 0
               // print("g")
              //  print(leftNumAboveDecimal)
              //  print(rightNumAboveDecimal)
                var addedValue = addingLeftNum + addingRightNum
                addedValue += carry
              //  print("addedValue: ", addedValue)
                //carry handling
                
                let sum = addingLeftNum + addingRightNum + carry
                addedValue = sum % 10
                carry = sum / 10
                
                newValueAboveDecimal.append(Character(String(addedValue)))
            }
            
            if carry != 0 {
                newValueAboveDecimal.append(Character(String(carry)))
            }
            
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
