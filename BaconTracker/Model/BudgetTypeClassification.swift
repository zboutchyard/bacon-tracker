//
//  BudgetClassification.swift
//  Pong
//
//  Created by Zack Boutchyard on 5/30/25.
//

import Foundation
import CoreML
import NaturalLanguage

struct BudgetTypeClassification {
    private let model: NLModel?
    
    init() {
        do {
            let coreMLModel = try BudgetClassification(configuration: MLModelConfiguration()).model
            self.model = try NLModel(mlModel: coreMLModel)
        } catch {
            print("Failed to load model: \(error)")
            self.model = nil
        }
    }
    
    func classify(_ memo: String, threshold: Double = 0.5) -> String {
        guard let model = model else {
            return "Other"
        }
        
        let prediction = model.predictedLabel(for: memo) ?? "Other"
        let probabilities = model.predictedLabelHypotheses(for: memo, maximumCount: 1)
        let confidence = probabilities[prediction] ?? 0.0
        
        if confidence >= threshold {
            return prediction
        } else {
            return "Other"
        }
    }
}
