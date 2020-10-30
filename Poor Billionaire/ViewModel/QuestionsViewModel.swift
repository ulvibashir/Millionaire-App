//
//  QuestionsViewModel.swift
//  Poor Billionaire
//
//  Created by Ulvi Bashirov on 10/21/20.
//

import Foundation
import UIKit

class QuestionsViewModel {
    var questions = [Question]()
    var totalPoints: Int = 0
    var currentStep: Int = 0
    var level = 1
    
    func getQuestion(diff: Difficulty, completion: @escaping () -> ()) {
        Network.request(diff: .easy, completion: { res in
//            res.results.forEach { item in
//                self.questions.append(item)
//            }
            self.questions = res.results
            for i in  0..<self.questions.count {
                let ans = self.questions[i].correctAnswer ?? ""
                self.questions[i].answers?.append(ans)
                self.questions[i].answers?.shuffle()
            }
            
            completion()
        })
    }
    
    func tapOption(selectedIndexPath: IndexPath, completion: @escaping (Bool, Int) -> ()) {
        let result = getResult(indexPath: selectedIndexPath)
        let point = level * 100
        if result {
            totalPoints += point
        } else {
            totalPoints -= point
        }
        
        currentStep += 1
        
        if currentStep == 10 {
            
            let diff: Difficulty = level == 1 ? .medium : level == 2 ? .hard : .medium
            getQuestion(diff: diff) {
                self.currentStep = 0
                self.level += 1
                completion(result, point)
            }
        } else {
            completion(result, point)
        }
    }
    
    func getResult(indexPath: IndexPath) -> Bool {
        if questions[currentStep].answers?[indexPath.row] == questions[currentStep].correctAnswer {
            return true
        }
        return false
    }
}
