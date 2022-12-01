//
//  QuizModel.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 16/11/22.
//

import SwiftUI
import Foundation


struct Quiz{
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
    
}

struct QuizOption : Identifiable{
    var id: Int
    var optionId: String
    var option :  String
    var isSelected : Bool = false
    var isMatched : Bool = false
}
