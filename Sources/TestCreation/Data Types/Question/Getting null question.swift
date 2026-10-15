//
//  Getting null question.swift
//  TestCreation
//
//  Created by Desire on 2026-07-02.
//

@available(iOS 13, *)
@available(macOS 10.15, *)
public extension Question {
    
    @MainActor
    static func getNullQuestion() -> Question {
        let questionWords = "null"
        //MARK: FIX THIS
        let questionContent2 = QuestionContent(AnyView(EmptyView()))
        
        let nullQuestion = Question(creator: UUID(), questionName: "Null Question", questionText: "Null Question", questionContent: questionContent2 , questionContentSizeX: CGFloat(500), questionContentSizeY: CGFloat(500), questionAnswer: questionWords)
        return nullQuestion
    }
    
    
}
