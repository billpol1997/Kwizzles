//
//  GameManagerVM.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 16/11/22.
//

import SwiftUI
import Foundation

class GameViewModel : ObservableObject {
    
    typealias quiz = QuizData
    
    //MARK: Vars
    static var currentIndex = 0
    static var maxIndex = 20
    @State var pressed : Bool = false
    @State var timeRunning = false
    @Published var totalPoints : Int = 0

    
    static func createGameModel(i:Int) ->Quiz {
        return Quiz(currentQuestionIndex: i, quizModel: quiz().randomizeQuestions()[i]) // QuizData[i]
    }
    
    @Published var model = GameViewModel.createGameModel(i: GameViewModel.currentIndex)
    
    var timer = Timer()
    var maxProgress = 15
    @Published var progress = 0
    
    //MARK: init
    init(){
        //self.startTimer()
    }
    
    //MARK: Start
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats:true, block: { time in
            if self.progress == self.maxProgress {
//                self.model.quizCompleted = true
//                self.model.quizWinningStatus = false
                self.nextQ()
               // self.resetTimer()
            } else {
                self.progress += 1
            }
        })
    }
    
    //MARK: Destroy timer
    func destroyTimer(){
        timer.invalidate()
        self.progress = 0
    }
    
    //MARK: Reset
    func resetTimer() {
        self.progress = 0
    }
    
    //MARK: Restart
    func restartGame() {
        GameViewModel.currentIndex = 0
        totalPoints = 0
        model = GameViewModel.createGameModel(i: GameViewModel.currentIndex)
        self.startTimer()
    }
    
    func isEndOfCounter() -> Bool {
        return self.progress == self.maxProgress
    }
    
    func nextQ(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if (GameViewModel.currentIndex < 19  ) {             // max thesi - 1 gia na doulepsei, QuizData.count - 1,quiz().data.count - 1
                GameViewModel.currentIndex = GameViewModel.currentIndex + 1
                self.resetTimer()
                self.model = GameViewModel.createGameModel(i: GameViewModel.currentIndex)
            } else {
                self.model.quizCompleted = true
                //self.model.quizWinningStatus = true
                self.destroyTimer()
            }
        }
    }
    //MARK: Verify
    func verifyAnswer(selectedOption: QuizOption) {
        for index in model.quizModel.optionsList.indices {
            model.quizModel.optionsList[index].isMatched = false
            model.quizModel.optionsList[index].isSelected = false
            
        }
        if let index = model.quizModel.optionsList.firstIndex(where: {$0.optionId == selectedOption.optionId}) {
            if selectedOption.optionId ==  model.quizModel.answer {
                model.quizModel.optionsList[index].isMatched = true
                model.quizModel.optionsList[index].isSelected = true
                totalPoints += model.quizModel.points
                pressed = true
                nextQ()
            } else {
                model.quizModel.optionsList[index].isMatched = false
                model.quizModel.optionsList[index].isSelected = true
                pressed = true
                nextQ()
            }
            
        }
    }
}
