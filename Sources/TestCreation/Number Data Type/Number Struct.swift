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
    
}
