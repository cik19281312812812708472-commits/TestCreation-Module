//
//  SentenceAnalyzer.swift
//  TestCreation
//
//  Created by Desire on 2026-10-21.
//


import Foundation
import PythonKit

public struct SentenceAnalyzer {
    public var crossEncoderModel: PythonObject
    public var sentenceTransformerModel: PythonObject
    public var torch: PythonObject
    public var sentenceTransformers: PythonObject
    
    
    init() {
        
        self.torch = Python.import("torch")
        self.sentenceTransformers = Python.import("sentence_transformers")
        
        let SentenceTransformer = sentenceTransformers.SentenceTransformer
        let CrossEncoder = sentenceTransformers.CrossEncoder
        let util = sentenceTransformers.util
        let mpsAvailable = Bool(String(torch.backends.mps.is_available()) ?? "") ?? false
        let device = mpsAvailable ? "mps" : "cpu"
        
        
        var crossEncoderModel: PythonObject = PythonObject(floatLiteral: 0)
        var sentenceTransformerModel: PythonObject = PythonObject(floatLiteral: 0)
        let fileManager = FileManager.default
        let modelsURL = URL.applicationSupportDirectory
            .appendingPathComponent("com.techdicto.Delta")
            .appendingPathComponent("Models")
        let crossEncoderModelURL = modelsURL.appendingPathComponent("crossEncoderModel")
        let sentenceTransformerURL = modelsURL.appendingPathComponent("sentenceTransformerModel")
        
        
        if UserDefaults.standard.bool(forKey: "Downloaded TestCreation Models") {
            
            
            crossEncoderModel = CrossEncoder(URL.toString(crossEncoderModelURL), device: device)
            sentenceTransformerModel = SentenceTransformer(URL.toString(sentenceTransformerURL))
            
        } else {
            crossEncoderModel = CrossEncoder("cross-encoder/nli-deberta-v3-base", device: device)
            sentenceTransformerModel = SentenceTransformer("all-MiniLM-L6-v2")
            
            crossEncoderModel.save(URL.toString(crossEncoderModelURL))
            sentenceTransformerModel.save(URL.toString(sentenceTransformerURL))
            UserDefaults.standard.set(true, forKey: "Downloaded TestCreation Models")
        }
        
        
        
        if crossEncoderModel == PythonObject(floatLiteral: 0) {
            fatalError("Failed to initialize the crossEncoderModel")
        }
        if sentenceTransformerModel == PythonObject(floatLiteral: 0) {
            fatalError("Failed to initialize the sentenceTransformerModel")
        }
        
        self.crossEncoderModel = crossEncoderModel
        self.sentenceTransformerModel = sentenceTransformerModel
      
        
        
        
    }
    
    
    public func analyze(originalSentence: String, testedSentence: String) -> [String] {
        // 1. Ensure Python environment and PythonKit are ready
       

        // 2. Import Python modules
    
    
        let emb1 = sentenceTransformerModel.encode(originalSentence, convert_to_tensor: true)
        let emb2 = sentenceTransformerModel.encode(testedSentence, convert_to_tensor: true)
    
        // 4. Compute Cosine Similarity and Distance
        let distance = Double(String(torch.dist(emb1, emb2).item()) ?? "") ?? 0.0

        // 5. Select device (MPS for Apple Silicon acceleration or CPU)
        let mpsAvailable = Bool(String(torch.backends.mps.is_available()) ?? "") ?? false
        let device = mpsAvailable ? "mps" : "cpu"


        // 6. CrossEncoder prediction (Passing a list of pairs: [[orig, tested]])
        let pairList = Python.list([[originalSentence, testedSentence]])
        
       // print(pairList)
        let scores = crossEncoderModel.predict(pairList)
        //print("scores: ", scores)
        // 7. Apply Softmax to get probabilities
        let tensorScores = torch.tensor(scores[0])
        let probsTensor = torch.softmax(tensorScores, dim: 0)

        // Convert Python tensor to Swift array of Doubles
        var probs: [Double] = []
        for prob in probsTensor.tolist() {
            probs.append(Double(String(describing: prob))!)
           // print("prob: ", prob)
        }

        let labels = ["Contradiction", "Entailment", "Neutral"]

        
        // 8. Find winning label index
        //This fails
       
        //  let topIdxPython = Int(String(torch.argmax(torch.tensor(probs)).item())!) ?? 2
        //print("topIdxPython: ", topIdxPython)
       
        
        //var output = ""
        /*
         --- AI Analysis Results ---
         Contradiction: 99.88%
         Entailment: 0.02%
         Neutral: 0.10%
         Topic Similarity: 0.7432
         Exact Topic similarity = 0.7166433334350586

         Result: Contradiction
         */
         
        var winingLabelIndex = 0
        if labels.count == probs.count {
            var topPercentage = 0.0
            for i in 0..<labels.count {
                let prob = probs[i]
                let label = labels[i]
                //print("prob: ", prob)
                let percentage = prob * 100
                if topPercentage < percentage {
                    winingLabelIndex = i
                    topPercentage = percentage
                }
              //  output += "\(label): \(String(percentage))%\n"
            }
        } else {
            print("not")
        }
        
        let winningLabel = labels[winingLabelIndex]
        
        /*
        for (label, prob) in zip(labels, probs) {
          
            let percentage = String(format: "%.2f", prob * 100)
            
        }

        output += "Topic Similarity: \(String(format: "%.4f", cosSim))\n"
        output += "Exact Topic distance = \(String(format: "%.4f", distance))\n"
        output += "\nResult: \(winningLabel)"
         print(output)*/
        
        print(labels)
        print(probs)
        print(["\(winningLabel)", "\(String(format: "%.4f", distance))"])
        return ["\(winningLabel)", "\(String(format: "%.4f", distance))"]
    }
}
