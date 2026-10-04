//
//  Question.swift
//  TestCreation
//
//  Created by Desire on 2026-07-02.
//

@available(macOS 10.15, iOS 13, *)
extension Question {
    
    public enum MulptilpleChoiceAnswers: String {
        
        case choice1 = "1"
        case choice2 = "2"
        case choice3 = "3"
        case choice4 = "4"
        
    }
    
}
//MARK: MAKE IT THAT EACH QUESTION CAN HAVE CONTENT FOR iOS and macOS
//add possibility for questiosn to be true or false
@available(macOS 10.15, iOS 13, *)
public struct Question: Identifiable, Equatable {
    
    public typealias Input = String
    public typealias Answer = String
    
    ///Identifiyng stuff
    public var id = UUID()
    
    public var questionName: String
    
    ///it is stored as UUID so that if the package owner changes its changes can still be remembered
    public var packageOwner: UUID
    
    public var letTestManagerCreateDescriptionOfQuestion: Bool
    
    public var questionType: QuestionType
    public var questionText: String = ""
 
    public var questionAnswer: String = ""
    
    public var questionContent: QuestionContent?
    public var questionContentSizeX: CGFloat
    public var questionContentSizeY: CGFloat
    
    ///This variable is for decribing what the question is. This has no effect on the UI and is just for the back end of things.
    public var questionDescription: String
    
    public var isAnswerCorrect: Bool = false
    
    ///this is simply a var to check if the input is th
    public var input: String = ""
    
    public var customCheckAnsFunc: ((Input, Answer) -> Bool)?
    
    //TODO: Special views will be created for this insted of it being stored here:
    //TODO: And special inputs views will be created for the question math answer and the question math input
   
    
    public mutating func checkAnswer() {
    
        if customCheckAnsFunc != nil {
            
            self.isAnswerCorrect = customCheckAnsFunc!(self.input, self.questionAnswer)
            
        } else {
            
            switch questionType {
            case .text:
                if self.questionAnswer == self.input {
                    self.isAnswerCorrect = true
                } else {
                    self.isAnswerCorrect = false
                }
            case .math:
                if self.questionAnswer == self.input {
                    self.isAnswerCorrect = true
                } else {
                    self.isAnswerCorrect = false
                }
            case .multipleChoice:
                if self.questionAnswer == self.input {
                    self.isAnswerCorrect = true
                } else {
                    self.isAnswerCorrect = false
                }
            }
            
        }
    }
    
    
    
    public init(creator: UUID,
                questionName: String,
                questionType: QuestionType = .text,
                questionText: String,
                questionContent: QuestionContent,
                questionContentSizeX: CGFloat,
                questionContentSizeY: CGFloat,
                questionAnswer: String,
                checkAnswer: ((Input, Answer) -> Bool)? = nil,
                questionDescription: String = "",
                letTestManagerCreateDescriptionOfQuestion: Bool = true
    ) {
        
        self.packageOwner = creator
        
        self.questionName = questionName
        
        self.questionType = questionType
        self.questionText = questionText
        self.questionContent = questionContent
        self.questionContentSizeX = questionContentSizeX
        self.questionContentSizeY = questionContentSizeY
        self.questionAnswer = questionAnswer
        self.customCheckAnsFunc = checkAnswer
        self.questionDescription = questionDescription
        self.letTestManagerCreateDescriptionOfQuestion = letTestManagerCreateDescriptionOfQuestion
        
    }
    
    
    
    
}

