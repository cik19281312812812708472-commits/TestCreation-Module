//
//  Description of Question.swift
//  TestCreation
//
//  Created by Desire on 2026-06-08.
//

import Foundation

@available(macOS 10.15, *)
public struct DescriptionOfQuestion: Codable {
    
    
    public var creatorInternalName: String
    
    public var extraDescription: String
    
    public var questionName: String
    public var questionText: String
    public var questionAnswer: String
    
    ///What is already inputed into the question
    public var questionInput: String
    
    ///This tracks the current question Index.
    public var questionIndex: Int
    
    
    public init(ownerInternalName: String, question: Question, extraDescription: String = "", questionIndex: Int = 0) {
        self.creatorInternalName = ownerInternalName
        self.questionName = question.questionName
        self.questionText = question.questionText
        self.questionAnswer = question.questionAnswer
        self.questionInput = question.input
        self.extraDescription = extraDescription
        self.questionIndex = questionIndex
    }
    
    public init(ownerInternalName: String, questionName: String, questionText: String, questionAnswer: String, questionInput: String, extraDescription: String = "", questionIndex: Int = 0) {
        self.creatorInternalName = ownerInternalName
        self.questionName = questionName
        self.questionText = questionText
        self.questionAnswer = questionAnswer
        self.questionInput = questionInput
        self.extraDescription = extraDescription
        self.questionIndex = questionIndex
        
    }
    
    
    
    
}
