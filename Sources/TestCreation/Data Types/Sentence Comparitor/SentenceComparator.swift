//
//  SentenceComparator.swift
//  TestCreation
//
//  Created by Desire on 2026-10-18.
//

#if os(iOS)

extension Question {
    
    func compareInputAndAnswerViaAI(input: String, answer: String) -> String {
        
        let comparator = SentenceComparator()
        

        if let score = comparator.compareSentences(input, answer) {
            return score.description
            // A higher score indicates a closer semantic match.
        }
        
    }
    
}


import Foundation
import MediaPipeTasksText

class SentenceComparator {
    private var textEmbedder: TextEmbedder?

    init() {
        setupEmbedder()
    }

    private func setupEmbedder() {
        // Locate the .tflite model file bundled in your Xcode project
        guard let modelPath = Bundle.main.path(forResource: "your_model_name", ofType: "tflite") else {
            print("Failed to find model file in bundle.")
            return
        }

        // Configure options
        let options = TextEmbedderOptions()
        options.baseOptions.modelAssetPath = modelPath
        options.quantize = true // Optimizes memory footprint on-device

        do {
            // Initialize the embedder
            self.textEmbedder = try TextEmbedder(options: options)
        } catch {
            print("Failed to initialize TextEmbedder: \(error)")
        }
    }

    /// Compares two sentences and returns a cosine similarity score (0.0 to 1.0+)
    func compareSentences(_ sentenceA: String, _ sentenceB: String) -> Float? {
        guard let embedder = textEmbedder else { return nil }

        do {
            // Generate vector embeddings for both strings
            let resultA = try embedder.embed(text: sentenceA)
            let resultB = try embedder.embed(text: sentenceB)
            
            // Extract the Embedding from EmbeddingResult
            guard let embeddingA = resultA.embeddingResult.embeddings.first,
                  let embeddingB = resultB.embeddingResult.embeddings.first else {
                print("No embeddings found in results.")
                return nil
            }
            
            // Pass correct argument label and type
            let similarity = try TextEmbedder.cosineSimilarity(
                embedding1: embeddingA,
                embedding2: embeddingB
            )
            
            return similarity
        } catch {
            print("Error computing similarity: \(error)")
            return nil
        }
    }
}


#else
//MARK: - macOS
import PythonKit
import Foundation

extension Question {
    
    func compareInputAndAnswerViaAI(input: String, answer: String) -> [String] {
       
        return SentenceAnalyzer.analyze(originalSentence: answer, testedSentence: input)
        
    }
    
}




#endif

