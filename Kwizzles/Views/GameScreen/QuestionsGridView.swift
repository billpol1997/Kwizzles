//
//  QuestionsGridView.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 16/11/22.
//

import SwiftUI
import Foundation

struct QuestionsGridView : View{
    
    @ObservedObject var viewModel : GameViewModel
    var columns : [GridItem] = Array(repeating: GridItem(.fixed(190),spacing: 0), count: 2)
    @State var text : String = " "
    
    var body: some View{
        VStack {
            question
           
            Spacer()
            LazyVGrid(columns: columns , spacing: 20){
                ForEach(viewModel.model.quizModel.optionsList){ quizOption in
                    BaseQuestionContainer(isAnswer: true, text: quizOption.option, isCorrect: quizOption.optionId == viewModel.model.quizModel.answer, action: {
                        viewModel.verifyAnswer(selectedOption: quizOption)
                    })
                }
            }
        }
        
    }
    
    var question: some View{
        BaseQuestionContainer(isAnswer: false, text: viewModel.model.quizModel.question, level: viewModel.model.quizModel.level,action: {})
    }
}
