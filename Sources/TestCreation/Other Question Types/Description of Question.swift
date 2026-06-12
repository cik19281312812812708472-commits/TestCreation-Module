//
//  Description of Question.swift
//  TestCreation
//
//  Created by Desire on 2026-06-08.
//

import Foundation

@available(macOS 10.15, *)
public struct DescriptionOfQuestion: Codable {
    
    
    //more description will be added
    public var creator: UUID
    public var questionName: String
    public var questionText: String
    public var questionAnswer: String
    public var questionInput: String
    
   
    public init(question: Question) {
        self.creator = question.packageOwner
        self.questionName = question.questionName
        self.questionText = question.questionText
        self.questionAnswer = question.questionAnswer
        self.questionInput = question.input
    }
    
}
