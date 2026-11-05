//
//  AutoCorrect.swift
//  TestCreation
//
//  Created by Desire on 2026-11-05.
//
import AppKit
import NaturalLanguage

extension SentenceAnalyzer {
    
    func autocorrectSentenceMacOS(sentence: String) -> String {
        let spellChecker = NSSpellChecker.shared
        var correctedSentence = sentence
        
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(sentence)
        
        let detectedLanguageCode: String = recognizer.dominantLanguage?.rawValue ?? NSSpellChecker.shared.language()
        
        while true {
            // Always calculate the fresh range of the current string state
            let range = NSRange(location: 0, length: correctedSentence.utf16.count)
            
            // Find the first misspelled word in the text
            let misspelledRange = spellChecker.checkSpelling(
                of: correctedSentence,
                startingAt: 0,
                language: detectedLanguageCode,
                wrap: false,
                inSpellDocumentWithTag: 0,
                wordCount: nil
            )
            
            // Break the loop if no more typos are found
            guard misspelledRange.location != NSNotFound else { break }
            
            // Convert the NSRange to a Swift String Range
            if let currentRange = Range(misspelledRange, in: correctedSentence) {
                // Fetch system guesses for that specific misspelled block
                if let guesses = spellChecker.guesses(
                    forWordRange: misspelledRange,
                    in: correctedSentence,
                    language: detectedLanguageCode,
                    inSpellDocumentWithTag: 0
                   ), let topGuess = guesses.first {
                    
                    // Replace the typo with the system's best guess
                    correctedSentence.replaceSubrange(currentRange, with: topGuess)
                } else {
                    // If there are no smart guesses, break to prevent an infinite loop
                    break
                }
            }
        }
        
        return correctedSentence
    }

}
