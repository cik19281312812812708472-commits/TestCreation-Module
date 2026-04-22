//
//  Untitled.swift
//  TestCreation
//
//  Created by Desire on 2026-04-21.
//


public struct Number: ExpressibleByIntegerLiteral, Sendable {
    
    public let value: String
    public let sign: SignBlueprint
    
    public init(_ value: Int, sign: SignBlueprint = .positive) {
        self.value = String(value)
        self.sign = sign
    }
    
    public init(_ value: Double,  sign: SignBlueprint = .positive) {
        self.value = String(value)
        self.sign = sign
    }
    
    public init(_ value: String,  sign: SignBlueprint = .positive) {
        self.value = value
        self.sign = sign
    }
   
    public init(integerLiteral value: Int) {
        self.value = String(value)
        
        if value < 0 {
            self.sign = .negative
        } else {
            self.sign = .positive
        }
        
    }
    
    
    public init(stringLiteral value: String, sign: SignBlueprint? = nil) {
        
        
        var arrayValue: [Character] = Array(value)
        if sign != nil {
            if arrayValue[0] == "-" {
                self.sign = .negative
            } else {
                self.sign = .positive
            }
        } else {
            self.sign = sign ?? .positive
        }
        var trueValue: String = ""
        
        arrayValue.removeFirst()
        
        var repeatingTimes: Int = arrayValue.count
        for i in 0..<repeatingTimes {
            
            var number: String = String(arrayValue[i])
            
            //
            if Number.allPossibleNumberDigits.contains(number) == false {
                
      
               // arrayValue[i] = "0"
                number = "0"
            }
              //after checking everything we can add it
            trueValue += number
            
            if i > arrayValue.count {
                break
            }
                
        }
        
       
        
        
        
        self.value = trueValue
        
        
        
        
    }
    
    
    
}
