//
//  Description of Question.swift
//  TestCreation
//
//  Created by Desire on 2026-06-08.
//


@available(macOS 10.15, *)
public struct DescriptionOfQuestion: Codable {
    
    
    //more description will be added
    public var questionName: String
    public var questionText: String
    public var questionAnswer: String
    public var questionInput: String
    
   
    public init(question: Question) {
        
        self.questionName = question.questionName
        self.questionText = question.questionText
        self.questionAnswer = question.questionAnswer
        self.questionInput = question.input
    }
    
}
