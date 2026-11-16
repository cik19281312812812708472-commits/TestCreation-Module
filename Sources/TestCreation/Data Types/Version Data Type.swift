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
    
    public enum VersionConversionErrors: Error {
        case stringVersionInvalid
    }
    
    public func convertStringToVersion(_ stringVersion: String) throws -> Version {
        let arrayVersion = stringVersion.split(separator: "\n")[0].replacingOccurrences(of: ".", with: " ").split(separator: " ").map(String.init)
     //  print(arrayPackageVersion)
        if (arrayVersion.count == 3) {
            if let major = Int(arrayVersion[0]), let minor = Int(arrayVersion[1]), let patch = Int(arrayVersion[2]) {
                let version = Version(Major: major, Minor: minor, Patch: patch)
                return version
            } else {
                throw VersionConversionErrors.stringVersionInvalid
            }
        } else {
            throw VersionConversionErrors.stringVersionInvalid
        }
    }
    
}
