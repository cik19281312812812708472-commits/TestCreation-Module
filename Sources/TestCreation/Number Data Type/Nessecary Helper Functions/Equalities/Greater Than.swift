//
//  Greater Than.swift
//  TestCreation
//
//  Created by Desire on 2026-08-09.
//

extension Number {
    
    
    public static func > (lhs: Number, rhs: Number) -> Bool {
       
        let sign1 = (lhs.sign == .positive) ? 1 : 0
        let sign2 = (rhs.sign == .positive) ? 1 : 0
        
        if sign1 < sign2 {
          //  print("here")
            return false;
        } else if sign1 > sign2 {
          //  print("here2")
            return true;
        }
        
        //the $0 is each element in a loop
        var leftNum: [Character] = Array(lhs.value.reversed())
        var parts: [Array<Character>.SubSequence] = (leftNum.split { $0 == "."}).reversed()
     //   print("parts: ", parts)
        let leftNumAboveDecimal: [Character] = Array(parts[0])
        var leftNumBelowDecimal: [Character] = []
        
       // guard leftNum.count > 1 else { return false }
        
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
        
        if leftNumAboveDecimal.count < rightNumAboveDecimal.count {
           // print("Here3")
            return false
        } else if leftNumAboveDecimal.count > rightNumAboveDecimal.count {
           // print("here4")
            return true
        }
        
        //look at the first number then iterate through it all till a number bigger has been found.
        
        //parts are the same
        
        let leftNumAboveDecimalCount = leftNumAboveDecimal.count
        let rightNumAboveDecimalCount = rightNumAboveDecimal.count
        //We start at 1 so we access the first digit(arrays start at 0)
        for i in 1...leftNumAboveDecimal.count {
            
            let leftNumDigit = convertCharToInt(leftNumAboveDecimal[leftNumAboveDecimalCount - i]) ?? 0
            let rightNumDigit = convertCharToInt(rightNumAboveDecimal[rightNumAboveDecimalCount - i]) ?? 0
           // print("leftNumdigit: ", leftNumDigit)
           // print("rightNumDIgit: ", rightNumDigit)
            if leftNumDigit > rightNumDigit {
                //print("here5")
                return true
            } else if leftNumDigit < rightNumDigit {
               // print("here6")
                return false
            }
            
            
        }
        
        let leftNumBelowDecimalCount = leftNumBelowDecimal.count
        let rightNumBelowDecimalCount = rightNumBelowDecimal.count
        
        
        guard leftNumBelowDecimalCount > 0 && rightNumBelowDecimalCount > 0 else {
            
            //it is equal to
            return false
        }
        
        for i in 1...leftNumBelowDecimalCount {
            
            let leftNumDigit = convertCharToInt(leftNumBelowDecimal[leftNumBelowDecimalCount - i]) ?? 0
            let rightNumDigit = convertCharToInt(rightNumBelowDecimal[rightNumBelowDecimalCount - i]) ?? 0
            
            if leftNumDigit > rightNumDigit {
                //print("here7")
                return true
            } else if leftNumDigit < rightNumDigit {
                //print("here8")
                return false
            }
            
            
        }
        
        //print("here9")
        
        //it is equal to the number
        return false
    }
        
    
    static func convertCharToInt(_ char: Character) -> Int? {
        return Int(String(char))
    }
    
}
