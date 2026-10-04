//
//  Multiple choice protocal.swift
//  TestCreation
//
//  Created by Desire on 2026-08-11.
//
@available(macOS 10.15, iOS 13.0, *)
public typealias choice = (name: String, color: Color)

@available(macOS 10.15, iOS 13.0, *)
public protocol MulptilpleChoiceQuestion {

    var multipleChoiceAnswers: MulptilpleChoiceAnswers { get set }
    
}

@available(macOS 10.15, iOS 13.0, *)
public struct MulptilpleChoiceAnswers {
    
    private(set) var choices: [choice]
    
    ///You are limited by only 6 questions.
    public mutating func append(_ choice: choice) {
        
        
        if choices.count + 1 <= 6 {
            
            choices.append(choice)
        } else {
            
        }
    }
    
    public mutating func remove(at index: Int) {
        choices.remove(at: index)
    }
    
}
