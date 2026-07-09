//
//  Question.swift
//  TestCreation
//
//  Created by Desire on 2026-07-02.
//

//add possibility for questiosn to be true or false
@available(macOS 10.15, iOS 13, *)
public struct Question: Identifiable, Equatable {
    
    ///Identifiyng stuff
    public var id = UUID()
    
    public var questionName: String
    
    ///it is stored as UUID so that if the package owner changes its changes can still be remembered
    public var packageOwner: UUID
    
    public var letTestManagerCreateDescriptionOfQuestion: Bool
    
    public var questionType: QuestionType
    public var questionText: String = ""
    
   // public var questionContent: Any
    ///should only be a string
    public var questionAnswer: String = ""
    public var questionMathAnswer: mathEquationBlueprint = mathEquationBlueprint(leftSide: [mathEquationBlueprint.Term(sign: .positive, factors: [mathEquationBlueprint.factor(topBase: "0", bottomBase: "1", squareRoot: false)])], relation: .equal, rightSide: [mathEquationBlueprint.Term(sign: .positive, factors: [mathEquationBlueprint.factor(topBase: "0", bottomBase: "1", squareRoot: false)])])
    
    

    public var questionContent: QuestionContent?
    public var questionContentSizeX: CGFloat
    public var questionContentSizeY: CGFloat
    
    ///This variable is for decribing what the question is. This has no effect on the UI and is just for the back end of things.
    public var questionDescription: String
    
    public var isAnswerCorrect: Bool = false
    
    ///this is simply a var to check if the input is th
    public var input: String = ""
    public var inputMath: mathEquationBlueprint = mathEquationBlueprint(leftSide: [mathEquationBlueprint.Term(sign: .positive, factors: [mathEquationBlueprint.factor(topBase: "0", bottomBase: "1", squareRoot: false)])], relation: .equal, rightSide: [mathEquationBlueprint.Term(sign: .positive, factors: [mathEquationBlueprint.factor(topBase: "0", bottomBase: "1", squareRoot: false)])])
    
    
    public mutating func checkAnswer() {
        
        switch self.questionType {
        case .text:
            if self.questionAnswer == self.input {
                self.isAnswerCorrect = true
            } else {
                self.isAnswerCorrect = false
            }
        case .math:
            if self.questionMathAnswer == self.inputMath {
                self.isAnswerCorrect = true
            } else {
                self.isAnswerCorrect = false
            }
        }
      
    }
    
    
    public init(creator: UUID, questionName: String, questionType: QuestionType = .text, questionText: String, questionContent: QuestionContent, questionContentSizeX: CGFloat, questionContentSizeY: CGFloat, questionAnswer: String, questionDescription: String = "", letTestManagerCreateDescriptionOfQuestion: Bool = true) {
        
        self.packageOwner = creator
        
        self.questionName = questionName
        
        self.questionType = questionType
        self.questionText = questionText
        self.questionContent = questionContent
        self.questionContentSizeX = questionContentSizeX
        self.questionContentSizeY = questionContentSizeY
        self.questionAnswer = questionAnswer
        self.questionDescription = questionDescription
        self.letTestManagerCreateDescriptionOfQuestion = letTestManagerCreateDescriptionOfQuestion
    }
   
    
    private init(creator: UUID, questionName: String, questionType: QuestionType = .math, questionText: String, questionContent: QuestionContent, questionContentSizeX: CGFloat, questionContentSizeY: CGFloat, questionAnswer: mathEquationBlueprint, questionDescription: String = "", letTestManagerCreateDescriptionOfQuestion: Bool = true) {
        
        self.packageOwner = creator
        
        self.questionName = questionName
        
        self.questionType = questionType
        self.questionText = questionText
        self.questionContent = questionContent
        self.questionContentSizeX = questionContentSizeX
        self.questionContentSizeY = questionContentSizeY
        self.questionMathAnswer = questionAnswer
        self.questionDescription = questionDescription
        self.letTestManagerCreateDescriptionOfQuestion = letTestManagerCreateDescriptionOfQuestion
    }
    
    
}
