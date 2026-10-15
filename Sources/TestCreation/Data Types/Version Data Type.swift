//
//  Version Data Type.swift
//  TestCreation
//
//  Created by Desire on 2026-10-15.
//

public struct Version: Codable, Equatable, CustomStringConvertible {
    
    var Major: Int = 0
    var Minor: Int = 0
    var Patch: Int = 0
   
    public var description: String {
        return "\(Major).\(Minor).\(Patch)"
    }
    
    
    public init(Major: Int, Minor: Int, Patch: Int) {
        self.Major = Major
        self.Minor = Minor
        self.Patch = Patch
    }
    
}
