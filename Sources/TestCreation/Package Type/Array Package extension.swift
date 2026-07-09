//
//  Array Package extension.swift
//  TestCreation
//
//  Created by Desire on 2026-06-29.
//

@available(iOS 13, *)
@available(macOS 10.15, *)
extension Array where Element: Package {
    
    func findPackage(_ id: UUID) -> (any Package)? {
        
        
        let package: [any Package] = self.filter { $0.id == id}
        
        guard package.count > 0 else {
            return nil
        }
        
        return package[0]
    }
    
    
}
