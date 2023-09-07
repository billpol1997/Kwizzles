//
//  QuizModel.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 16/11/22.
//

import SwiftUI
import Foundation


struct Quiz {
    
    var currentQuestionIndex: Int
    var quizModel: QuizModel
    var quizCompleted : Bool = false
    var quizWinningStatus: Bool = false
}


struct QuizModel{
    
    var question: String
    var answer: String
    var optionsList : [QuizOption]
    var points : Int
    var level : String
    var isUsed: Bool
    
    init(with data: QuizJsonData) {
        self.question = data.question ?? ""
        self.answer = data.answer ?? ""
        self.optionsList = data.options.map({ items -> [QuizOption] in
            var tempArray: [QuizOption]
            tempArray = items.map{ item -> QuizOption in
                var temp: QuizOption =  QuizOption(with: item)
                return temp
            }
            return tempArray
        }) ?? []
        self.points = data.points
        self.level = data.level ?? ""
        self.isUsed = false
    }
    
}

struct QuizOption : Identifiable{
    var id: Int
    var optionId: String
    var option :  String
    var isSelected : Bool = false
    var isMatched : Bool = false
    
    init(with options: OptionItems) {
        self.id = options.id ?? 1212
        self.optionId = options.optionId ?? ""
        self.option = options.option ?? ""
    }
}
