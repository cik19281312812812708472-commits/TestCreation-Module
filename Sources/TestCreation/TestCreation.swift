// The Swift Programming Language
// https://docs.swift.org/swift-book

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


public struct Question {
    
    
    
    
    public var questionText: String
    
    
    public var questionContent: Any
    public var questionAnswer: Any
    
    
    
   
    
}

 






