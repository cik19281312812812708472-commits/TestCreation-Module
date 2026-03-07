// The Swift Programming Language
// https://docs.swift.org/swift-book



public struct mathEquationBlueprint: Equatable {
    
    public enum SignBlueprint: Equatable {
        case positive
        case negative
    }
    
    public enum RelationBlueprint: Equatable {
        
        case equal
        case greaterThan
        case lessThan
        
    }
    
    public enum locationBlueprint: Equatable {
        case leftSide
        case rightSide
    }
    
    ///use the bla bla blah
    public struct factor: Equatable {
        public var topBase: String
        public var bottomBase: String
        public var exponent: Int?
        public var squareRoot: Bool
        
        public init(topBase: String, bottomBase: String, exponent: Int? = nil, squareRoot: Bool) {
            self.topBase = topBase
            self.bottomBase = bottomBase
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
    
    
    ///it  is counting from the center so on the left side 2 would be t terms to the right
    public var leftSide: [Term]
    public var relation: RelationBlueprint
    public var rightSide: [Term]
    
    
    
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

 


