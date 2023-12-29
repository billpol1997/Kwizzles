//
//  QuizData.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 16/11/22.
//

import Foundation
import SwiftUI

class QuizDataFactory {
    var json: QnAResponse
    var data: [QuizModel]
    var errorj = QuizJsonData(question: "ERROR", answer: "ERROR", options: nil, points: 0, level: nil)
    var errorQ: QuizModel
    
    init() {
        self.json = QuizManager.shared.getDataFromJSON()
        self.data = self.json.quiz.map({ data -> [QuizModel] in
            let transitionalArray = data.map { item -> QuizModel in
                let transitionalItem = QuizModel(with: item)
                return transitionalItem
            }
            return transitionalArray
        }) ?? []
        self.errorQ = QuizModel(with: errorj)
    }
    
//    func fetchQuestionBasedOnLevel(with level: GameLevels) -> [QuizModel] {
//        var questions: [QuizModel] = []
//        let levelArray = data.filter { model in
//            model.level == level.rawValue
//        }
//        
//        while questions.count < 20 {
//            var randomIndex = Int(arc4random_uniform(UInt32(levelArray.count)))
//            while questions.contains(where: { model in
//                model.question == levelArray[randomIndex].question
//            }) {
//                randomIndex = Int(arc4random_uniform(UInt32(levelArray.count)))
//            }
//            questions.append(levelArray[randomIndex])
//        }
//
//        return questions
//    }
//    
//    func presentQuestionList(with level: GameLevels) -> [QuizModel] {
//        var begginersQ: [QuizModel] = []
//        var intermediateQ: [QuizModel] = []
//        var proQ: [QuizModel] = []
//        var masterQ: [QuizModel] = []
//        var questions: [QuizModel] = []
//        
//        begginersQ.append(contentsOf: fetchQuestionBasedOnLevel(with: .beginner))
//        intermediateQ.append(contentsOf: fetchQuestionBasedOnLevel(with: .intermediate))
//        proQ.append(contentsOf: fetchQuestionBasedOnLevel(with: .pro))
//        masterQ.append(contentsOf: fetchQuestionBasedOnLevel(with: .master))
//        
//        switch level {
//        case .beginner:
//            questions = begginersQ
//        case .intermediate:
//            questions = intermediateQ
//        case .pro:
//            questions = proQ
//        case .master:
//            questions = masterQ
//        }
//        
//        return questions
//    }
//    
    
    func selectRandomQuestionBasedOnLevel(with level: GameLevels) -> QuizModel {
        let levelArray = data.filter { model in
            model.level == level.rawValue
        }
        
        var randomIndex = Int(arc4random_uniform(UInt32(levelArray.count)))
        
        while levelArray[randomIndex].isUsed {
            randomIndex = Int(arc4random_uniform(UInt32(levelArray.count)))
        }
        
        return levelArray[randomIndex]
    }
    
    func fetchNextQuestion(with level: GameLevels) -> QuizModel {
        let question = selectRandomQuestionBasedOnLevel(with: level)
        
        return question
    }
}
