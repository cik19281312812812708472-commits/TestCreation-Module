//
//  SentenceAnalyzer.swift
//  TestCreation
//
//  Created by Desire on 2026-10-21.
//


import Foundation
import PythonKit

public enum SentenceAnalyzer {

    public static func analyze(originalSentence: String, testedSentence: String) -> [String] {
        // 1. Ensure Python environment and PythonKit are ready
        PythonEnvironment.initialize()

        // 2. Import Python modules
        let torch = Python.import("torch")
        let sentenceTransformers = Python.import("sentence_transformers")
        
        let SentenceTransformer = sentenceTransformers.SentenceTransformer
        let CrossEncoder = sentenceTransformers.CrossEncoder
        let util = sentenceTransformers.util

        // 3. Load models
        let model = SentenceTransformer("all-MiniLM-L6-v2")

        let emb1 = model.encode(originalSentence, convert_to_tensor: true)
        let emb2 = model.encode(testedSentence, convert_to_tensor: true)

        // 4. Compute Cosine Similarity and Distance
        let cosSim = Double(String(util.cos_sim(emb1, emb2).item()) ?? "") ?? 0.0
        let distance = Double(String(torch.dist(emb1, emb2).item()) ?? "") ?? 0.0

        // 5. Select device (MPS for Apple Silicon acceleration or CPU)
        let mpsAvailable = Bool(String(torch.backends.mps.is_available()) ?? "") ?? false
        let device = mpsAvailable ? "mps" : "cpu"
        let crossEncoderModel = CrossEncoder("cross-encoder/nli-deberta-v3-base", device: device)

        // 6. CrossEncoder prediction (Passing a list of pairs: [[orig, tested]])
        let pairList = Python.list([[originalSentence, testedSentence]])
        let scores = crossEncoderModel.predict(pairList)

        // 7. Apply Softmax to get probabilities
        let tensorScores = torch.tensor(scores[0])
        let probsTensor = torch.softmax(tensorScores, dim: 0)

        // Convert Python tensor to Swift array of Doubles
        var probs: [Double] = []
        for prob in probsTensor.tolist() {
            probs.append(Double(String(prob) ?? "") ?? 0.0)
        }

        let labels = ["Contradiction", "Entailment", "Neutral"]

        
        // 8. Find winning label index
        let topIdxPython = Int(String(torch.argmax(torch.tensor(probs)).item()) ?? "") ?? 0
        let winningLabel = labels[topIdxPython]
        
        /*
         --- AI Analysis Results ---
         Contradiction: 99.88%
         Entailment: 0.02%
         Neutral: 0.10%
         Topic Similarity: 0.7432
         Exact Topic similarity = 0.7166433334350586

         Result: Contradiction
         
         */
     
        /*
        for (label, prob) in zip(labels, probs) {
            let percentage = String(format: "%.2f", prob * 100)
            output += "\(label): \(percentage)%\n"
        }

        output += "Topic Similarity: \(String(format: "%.4f", cosSim))\n"
        output += "Exact Topic distance = \(String(format: "%.4f", distance))\n"
        output += "\nResult: \(winningLabel)"
         */
        
        return ["\(winningLabel)", "\(String(format: "%.4f", distance))"]
    }
}
