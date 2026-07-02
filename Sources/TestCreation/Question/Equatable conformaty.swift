//
//  Equatable conformaty.swift
//  TestCreation
//
//  Created by Desire on 2026-07-02.
//

@available(macOS 10.15, *)
public extension Question {
     static func == (lhs: Question, rhs: Question) -> Bool {
        lhs.questionText == rhs.questionText &&
        lhs.questionType == rhs.questionType &&
        lhs.id == rhs.id &&
        lhs.questionContentSizeX == rhs.questionContentSizeX &&
        lhs.questionContentSizeY == rhs.questionContentSizeY &&
        lhs.questionMathAnswer == rhs.questionMathAnswer &&
        lhs.questionAnswer == rhs.questionAnswer
    }
    
}
