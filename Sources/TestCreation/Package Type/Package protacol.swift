//
//  Package protacol.swift
//  Delta
//
//  Created by Desire on 2026-04-26.
//

import Foundation
import SwiftUI
import Combine


@available(macOS 10.15, *)
public protocol Package: ObservableObject, Identifiable {

    ///Please put your internal name as a let statement
    
    var publicName: String { get }
    var internalName: String { get }
    var packageDescription: String { get set }
    
    
    var id: UUID { get }
    
    
    var allChangbleBools: [boolSetting] { get set }
    var allChangbleInts: [intSetting] { get set }
    var allChangbleDoubles: [doubleSetting] { get set }
   
    
    //make a func call modify settings
    
   
    ///This function is required as it is to update the settings of your package after they have been updated in the UI.
    func updateInternalSettings()
    func createSection(numOfQuestions: Int) -> [Question]
    func createQuestion() -> Question
    
    ///This function is to recreate a specified question based on the data inputed. It is used for the loading of the questions in a test.
    func loadQuestion(descriptionOfQuestion: DescriptionOfQuestion) -> Question
    
    
    
    ///This is to modify question answers before they are checked.
    func filterAnswer(answer: String) -> String
    
    ///This is if a package wants to do stuff before it is used
    func setup()
    
    
}
//for each package a custom view will be needed but for now 


@available(macOS 10.15, *)
public extension Package {
    
    func changeABool(_ index: Int, to: Bool) {
        
        //add guard
        let currentIndexName: String = self.allChangbleBools[index].name
        let currentIndexID: UUID = self.allChangbleBools[index].id
        
        self.allChangbleBools[index] =  boolSetting(bool: to, name: currentIndexName, id: currentIndexID)
    }
    
    func changeAnInt(_ index: Int, to: Int) {
        
        let currentIndexName: String = self.allChangbleInts[index].name
        let currentIndexID: UUID = self.allChangbleInts[index].id
        
        self.allChangbleInts[index] = intSetting(int: to, name: currentIndexName, id: currentIndexID)
    }
    
    func changeADouble(_ index: Int, to: Double) {
        
        let currentIndexName: String = self.allChangbleDoubles[index].name
        let currentIndexID: UUID = self.allChangbleDoubles[index].id
        
        self.allChangbleDoubles[index] = doubleSetting(double: to, name: currentIndexName, id: currentIndexID)
    }
    
    
    ///This is a place holder incase you dont want to filter answers.
     func filterAnswer(answer: String) -> String {
        return answer
    }
    
    //this is auto nothing as some packages dont need it.
    func setup() {}
  
}


public enum allChangbleTypes {
    case bool
    case int
    case double
}


public struct boolSetting: Identifiable {
    
    public var bool: Bool
    public var name: String
    public var id = UUID()
    
    public var description: String
    
    public init(bool: Bool, name: String, id: UUID = UUID(), description: String = "") {
        self.bool = bool
        self.name = name
        self.id = id
        self.description = description
    }
    
}

public struct intSetting: Identifiable {
    
    public var int: Int
    
    public var tempIntString: String
    public var name: String
    public var id = UUID()
    
    public var description: String
    
    public init(int: Int, name: String, id: UUID = UUID(), description: String = "") {
        self.int = int
        self.tempIntString = String(int)
        self.name = name
        self.id = id
        self.description = description
    }
    
}

public struct doubleSetting: Identifiable {
    
    
    public var double: Double
    
    //why this is here will be explained
    public var tempDoubleString: String
    public var name: String
    public var id = UUID()
    
    public var description: String = ""
    
    public init(double: Double, name: String, id: UUID = UUID(), description: String = "") {
        self.double = double
        self.tempDoubleString = String(double)
        self.name = name
        self.id = id
        self.description = description
    }
    
}

public struct lightQuestion {
    
    public var questionWords: String
    public var answer: String
    
    public init(questionWords: String, answer: String) {
        self.questionWords = questionWords
        self.answer = answer
    }
    
}
