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
    
    
    
    
    
    func filterAnswer(answer: String) -> String
    
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
    
    public init(bool: Bool, name: String, id: UUID = UUID()) {
        self.bool = bool
        self.name = name
        self.id = id
    }
    
}

public struct intSetting: Identifiable {
    
    public var int: Int
    
    public var tempIntString: String
    public var name: String
    public var id = UUID()
    
    public init(int: Int, name: String, id: UUID = UUID()) {
        self.int = int
        self.tempIntString = String(int)
        self.name = name
        self.id = id
    }
    
}

public struct doubleSetting: Identifiable {
    
    
    public var double: Double
    
    //why this is here will be explained
    public var tempDoubleString: String = ""
    public var name: String
    public var id = UUID()
    
    public init(double: Double, name: String, id: UUID = UUID()) {
        self.double = double
        self.tempDoubleString = String(double)
        self.name = name
        self.id = id
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
