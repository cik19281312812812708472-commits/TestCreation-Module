// The Swift Programming Language
// https://docs.swift.org/swift-book

@_exported import SwiftUI
@_exported import Foundation

public enum SignBlueprint: Equatable, Sendable {
    case positive
    case negative
}

///this shows all the relations
public enum RelationBlueprint: Equatable {
    
    case equal
    case greaterThan
    case lessThan
    
}

public enum locationBlueprint: Equatable {
    case leftSide
    case rightSide
}


public struct mathEquationBlueprint: Equatable {
    
    
    
    
    //
   
    
    ///use the bla bla blah
    public struct factor: Equatable {
        
        public var numerator: String
        
        ///
        ///
        public var denominator: String
        public var expressingDenominator: Bool
        public var exponent: Int?
        public var squareRoot: Bool
        
        public init(topBase: String, bottomBase: String, expressingDenominator: Bool = false, exponent: Int? = nil, squareRoot: Bool) {
            self.numerator = topBase
            self.denominator = bottomBase
            self.expressingDenominator = expressingDenominator 
            self.exponent = exponent
            self.squareRoot = squareRoot
        }
    }
    
   
    public struct Term: Equatable {
        public var sign: SignBlueprint
        public var factors: [factor]
        
        public init(sign: SignBlueprint, factors: [factor]) {
            self.sign = sign
            self.factors = factors
        }
    }
    
    
    ///each math side represents the terms fron left to right.
    public var leftSide: [Term]
    public var relation: RelationBlueprint
    public var rightSide: [Term]
    
    
    ///
    public mutating func removeAllTerms(_ location: locationBlueprint, _ term: Term) {
        if location == .leftSide {
            leftSide.removeAll { $0 == term}
            
        } else {
            rightSide.removeAll { $0 == term}
        }
        
    }
    
    public init(leftSide: [Term], relation: RelationBlueprint, rightSide: [Term]) {
        self.leftSide = leftSide
        self.relation = relation
        self.rightSide = rightSide
        
    }
    
   
    
}

public enum QuestionType: String, Codable {
    case text
    case math
}


@available(macOS 10.15, iOS 13, *)
public struct QuestionContent: View {

    public var content: AnyView

    public init(_ content: AnyView) {

        self.content = content

    }

    public init<V: View>(@ViewBuilder builder: () -> V) {

        self.content = AnyView(builder())

    }

    public var body: some View {

        content

    }

}



//add possibility for questiosn to be true or false
@available(macOS 10.15, iOS 13, *)
public struct Question: Identifiable, Equatable {
    
    
    public static func == (lhs: Question, rhs: Question) -> Bool {
        lhs.questionText == rhs.questionText &&
        lhs.questionType == rhs.questionType &&
        lhs.id == rhs.id &&
        lhs.questionContentSizeX == rhs.questionContentSizeX &&
        lhs.questionContentSizeY == rhs.questionContentSizeY &&
        lhs.questionMathAnswer == rhs.questionMathAnswer &&
        lhs.questionAnswer == rhs.questionAnswer
    }
    
    
    ///Identifiyng stuff
    public var id = UUID()
    
    public var questionName: String
    
    ///it is stored as UUID so that if the package owner changes its changes can still be remembered
    public var packageOwner: UUID

    
    
    
    public var questionType: QuestionType
    public var questionText: String = ""
    
   // public var questionContent: Any
    ///should only be a string
    public var questionAnswer: String = ""
    public var questionMathAnswer: mathEquationBlueprint = mathEquationBlueprint(leftSide: [mathEquationBlueprint.Term(sign: .positive, factors: [mathEquationBlueprint.factor(topBase: "0", bottomBase: "1", squareRoot: false)])], relation: .equal, rightSide: [mathEquationBlueprint.Term(sign: .positive, factors: [mathEquationBlueprint.factor(topBase: "0", bottomBase: "1", squareRoot: false)])])
    
    

    public var questionContent: QuestionContent?
    public var questionContentSizeX: CGFloat
    public var questionContentSizeY: CGFloat
    
    
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
    
    
    public init(creator: UUID, questionName: String, questionType: QuestionType = .text, questionText: String, questionContent: QuestionContent, questionContentSizeX: CGFloat, questionContentSizeY: CGFloat, questionAnswer: String) {
        
        self.packageOwner = creator
        
        self.questionName = questionName
        
        self.questionType = questionType
        self.questionText = questionText
        self.questionContent = questionContent
        self.questionContentSizeX = questionContentSizeX
        self.questionContentSizeY = questionContentSizeY
        self.questionAnswer = questionAnswer
    }
   
    
    public init(creator: UUID, questionName: String, questionType: QuestionType = .math, questionText: String, questionContent: QuestionContent, questionContentSizeX: CGFloat, questionContentSizeY: CGFloat, questionAnswer: mathEquationBlueprint) {
        
        self.packageOwner = creator
        
        self.questionName = questionName
        
        self.questionType = questionType
        self.questionText = questionText
        self.questionContent = questionContent
        self.questionContentSizeX = questionContentSizeX
        self.questionContentSizeY = questionContentSizeY
        self.questionMathAnswer = questionAnswer
    }
    
    
}

 
@available(macOS 10.15, iOS 13, *)
struct mathEquationUIElement: View {

    var mathEquation: mathEquationBlueprint
    
   
    var body: some View {
        
    }
    
    init(mathEquation: mathEquationBlueprint) {
        self.mathEquation = mathEquation
    }
    
}






