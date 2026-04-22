//
//  Reversing Function.swift
//  TestCreation
//
//  Created by Desire on 2026-04-21.
//

///This function simply gets your number (with the 'Number' data type) seperates it and turns it into two character arrays
func reverseNumber(_ number: Number) -> reversedNumber {
    
    //the $0 is each element in a loop
    var numberReversed: [Character] = Array(number.value.reversed())
    var parts: [Array<Character>.SubSequence] = (numberReversed.split { $0 == "."}).reversed()
    print("parts: ", parts)
    let reversedNumberAboveDecimal: [Character] = Array(parts[0])
    var reversedNumberBelowDecimal: [Character] = []
    
    if parts.count > 1 {
        reversedNumberBelowDecimal = Array(parts[1])
    }
    
    let result: reversedNumber = reversedNumber(reversedNumber: numberReversed, partAboveDecimal: reversedNumberAboveDecimal, partBelowDecimal: reversedNumberBelowDecimal)
    
    return result
}



