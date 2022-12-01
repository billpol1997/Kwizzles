//
//  QuestionsGridView.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 16/11/22.
//

import SwiftUI
import Foundation

struct QuestionsGridView : View{
    
    var manager : GameManagerVM
    var columns : [GridItem] = Array(repeating: GridItem(.fixed(190),spacing: 0), count: 2)
    @State var text : String = " "
    
    var body: some View{
        
        
        VStack {
            question
           
            Spacer()
            LazyVGrid(columns: columns , spacing: 20){
                ForEach(manager.model.quizModel.optionsList){ quizOption in
                    BaseQuestionContainer(isAnswer: true, text: quizOption.option, isCorrect: quizOption.optionId == manager.model.quizModel.answer, action: {
                        manager.verifyAnswer(selectedOption: quizOption)
                    })
                }
            }
        }
        
    }
    
    var question: some View{
        BaseQuestionContainer(isAnswer: false, text: manager.model.quizModel.question, level: manager.model.quizModel.level,action: {})
    }
}
