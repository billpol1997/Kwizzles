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
    
    func levelAdjustmentProcess(currentLevel: GameLevels, earnedPointsOfLevel: CGFloat, totalLevelPoints: CGFloat) {
        
    }
    
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





//var QuizData : [QuizModel]{
//    [
//        QuizModel(question: "Test 1", answer: "D", optionsList: [
//            QuizOption(id: 11, optionId: "A", option: "A"),
//            QuizOption(id: 12, optionId: "B", option: "B"),
//            QuizOption(id: 13, optionId: "C", option: "C"),
//            QuizOption(id: 14, optionId: "D", option: "D")
//        ], points: 10, level: "Beginner"),
//
//        QuizModel(question: "Test 2", answer: "A", optionsList: [
//            QuizOption(id: 21, optionId: "A", option: "a"),
//            QuizOption(id: 22, optionId: "B", option: "b"),
//            QuizOption(id: 23, optionId: "C", option: "c"),
//            QuizOption(id: 24, optionId: "D", option: "d")
//        ], points: 10, level: "Intermediate"),
//
//        QuizModel(question: "Test 3", answer: "C", optionsList: [
//            QuizOption(id: 21, optionId: "A", option: "a"),
//            QuizOption(id: 22, optionId: "B", option: "b"),
//            QuizOption(id: 23, optionId: "C", option: "c"),
//            QuizOption(id: 24, optionId: "D", option: "d")
//        ], points: 10, level: "Beginner"),
//
//        QuizModel(question: "Test 4", answer: "B", optionsList: [
//            QuizOption(id: 21, optionId: "A", option: "a"),
//            QuizOption(id: 22, optionId: "B", option: "b"),
//            QuizOption(id: 23, optionId: "C", option: "c"),
//            QuizOption(id: 24, optionId: "D", option: "d")
//        ], points: 10, level: "Beginner"),
//
//        QuizModel(question: "Test 5", answer: "D", optionsList: [
//            QuizOption(id: 11, optionId: "A", option: "A"),
//            QuizOption(id: 12, optionId: "B", option: "B"),
//            QuizOption(id: 13, optionId: "C", option: "C"),
//            QuizOption(id: 14, optionId: "D", option: "D")
//        ], points: 10, level: "Beginner"),
//
//        QuizModel(question: "Test 6", answer: "A", optionsList: [
//            QuizOption(id: 21, optionId: "A", option: "a"),
//            QuizOption(id: 22, optionId: "B", option: "b"),
//            QuizOption(id: 23, optionId: "C", option: "c"),
//            QuizOption(id: 24, optionId: "D", option: "d")
//        ], points: 10, level: "Beginner"),
//
//        QuizModel(question: "Test 7", answer: "C", optionsList: [
//            QuizOption(id: 21, optionId: "A", option: "a"),
//            QuizOption(id: 22, optionId: "B", option: "b"),
//            QuizOption(id: 23, optionId: "C", option: "c"),
//            QuizOption(id: 24, optionId: "D", option: "d")
//        ], points: 10, level: "Beginner"),
//
//        QuizModel(question: "Test 8", answer: "B", optionsList: [
//            QuizOption(id: 21, optionId: "A", option: "a"),
//            QuizOption(id: 22, optionId: "B", option: "b"),
//            QuizOption(id: 23, optionId: "C", option: "c"),
//            QuizOption(id: 24, optionId: "D", option: "d")
//        ], points: 10, level: "Beginner")
//
//
//
//    ]
//}


//QuizModel(question: "Ποιός είναι ο πιό σέξυ άντρας ;", answer: <#T##String#>, optionList: [
//    QuizOption(id: 11, optionId: "A", option: <#T##String#>),
//    QuizOption(id: 12, optionId: "B", option: <#T##String#>),
//    QuizOption(id: 13, optionId: "C", option: <#T##String#>),
//    QuizOption(id: 14, optionId: "D", option: <#T##String#>)
//])
