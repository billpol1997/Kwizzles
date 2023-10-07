//
//  GameManagerVM.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 16/11/22.
//

import SwiftUI
import Foundation

enum GameLevels: String {
    case beginner
    case intermediate
    case pro
    case master
}

class GameViewModel : ObservableObject {
    
    typealias quiz = QuizData
    
    //MARK: Vars
    static var currentIndex = 0
    static var maxIndex = 20
    @State var pressed : Bool = false
    @State var timeRunning = false
    var levelPoints : Int = 0
    var totalLevelPoints : Int = 0
    var currentLevel: GameLevels
    var levelIndex: Int = 0
    @Published var earnedPoints : Int = 0
    @Published var hasChangedLevel = false

    //MARK: Create game
    static func createGameModel(i:Int, level: GameLevels? = .beginner) -> Quiz {
        return Quiz(currentQuestionIndex: i, quizModel: quiz().presentQuestionList(with: level ?? .beginner )[i]) // QuizData[i]
    }
    
    @Published var model = GameViewModel.createGameModel(i: GameViewModel.currentIndex)
    
    var timer = Timer()
    var maxProgress = 15
    @Published var progress = 0
    
    //MARK: init
    init(){
        //self.startTimer()
        self.currentLevel = .beginner
    }
    
    //MARK: Start timer
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
    
    func isEndOfCounter() -> Bool {
        return self.progress == self.maxProgress
    }
    
    //MARK: Restart
    func restartGame() {
        GameViewModel.currentIndex = 0
        earnedPoints = 0
        currentLevel = .beginner
        self.resetLevelComponents()
        model = GameViewModel.createGameModel(i: GameViewModel.currentIndex)
        self.startTimer()
    }
    
    
    
    //MARK: Next question
    func nextQ(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self else { return }
            if (GameViewModel.currentIndex < 19  ) {             // max thesi - 1 gia na doulepsei, QuizData.count - 1,quiz().data.count - 1
                GameViewModel.currentIndex = GameViewModel.currentIndex + 1
                self.levelIndex = self.levelIndex + 1
                self.adjustLevel()
                self.resetTimer()
                guard !self.hasChangedLevel else {
                    self.model = GameViewModel.createGameModel(i: GameViewModel.currentIndex, level: self.currentLevel)
                    return
                }
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
                earnedPoints += model.quizModel.points
            } else {
                model.quizModel.optionsList[index].isMatched = false
            }
            model.quizModel.optionsList[index].isSelected = true
            totalLevelPoints += model.quizModel.points
            pressed = true
            nextQ()
            
        }
    }
    
    //MARK: Level funcs
    func adjustLevel() {
        guard levelIndex == 5 else { return }
        if levelPoints  >= totalLevelPoints * Int(0.75) {
            self.levelUp()
        } else {
            self.levelDown()
        }
        self.hasChangedLevel = true
        self.resetLevelComponents()
    }
    
    func levelUp() {
        switch currentLevel {
        case .beginner:
            self.currentLevel = .intermediate
        case .intermediate:
            self.currentLevel = .pro
        case .pro:
            self.currentLevel = .master
        case .master:
            self.currentLevel = .master
        }
    }
    
    func levelDown() {
        switch currentLevel {
        case .beginner:
            self.currentLevel = .beginner
        case .intermediate:
            self.currentLevel = .beginner
        case .pro:
            self.currentLevel = .intermediate
        case .master:
            self.currentLevel = .pro
        }
    }
    
    func resetLevelComponents() {
        levelPoints = 0
        totalLevelPoints = 0
        levelIndex = 0
    }
}
