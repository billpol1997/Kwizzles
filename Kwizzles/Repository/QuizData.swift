//
//  QuizData.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 16/11/22.
//

import Foundation
import SwiftUI

class QuizData {
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
    
    func randomizeQuestions() -> [QuizModel] {
        var randomQuestions: [QuizModel] = []
        for index in 0...19 {
            randomQuestions.append(data.randomElement() ?? errorQ)
            if(randomQuestions.filter{ $0.question == randomQuestions[index].question }.count > 1) {
                randomQuestions.append(data.randomElement() ?? errorQ)
            }
        }
        return randomQuestions
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
