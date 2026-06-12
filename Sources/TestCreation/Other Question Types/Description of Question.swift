//
//  Description of Question.swift
//  TestCreation
//
//  Created by Desire on 2026-06-08.
//

import Foundation

@available(macOS 10.15, *)
public struct DescriptionOfQuestion: Codable {
    
    
    public var creator: UUID
    
    public var extraDescription: String
    
    public var questionName: String
    public var questionText: String
    public var questionAnswer: String
    public var questionInput: String
    
   
    public init(question: Question, extraDescription: String = "") {
        self.creator = question.packageOwner
        self.questionName = question.questionName
        self.questionText = question.questionText
        self.questionAnswer = question.questionAnswer
        self.questionInput = question.input
        self.extraDescription = extraDescription
    }
    
}
