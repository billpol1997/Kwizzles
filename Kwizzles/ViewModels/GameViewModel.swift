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

enum LevelAdjustmentState {
    case up
    case down
    case none
}

class GameViewModel : ObservableObject {
    
    typealias quiz = QuizDataFactory
    
    //MARK: Vars
    static var currentIndex = 0
    static var maxIndex = 20
    @State var pressed : Bool = false
    @State var timeRunning = false
    @Published var earnedPoints : Int = 0
    @Published var hasChangedLevel = false
    var levelPoints : CGFloat = 0.0
    var totalLevelPoints : CGFloat = 0.0
    var currentLevel: GameLevels
    var levelIndex: Int = 0
    var islevelUp: Bool = false
    
    //MARK: Create game
    static func createGameModel(i:Int, level: GameLevels? = .beginner) -> Quiz {
        // return Quiz(currentQuestionIndex: i, quizModel: quiz().presentQuestionList(with: level ?? .beginner )[i]) // QuizData[i]
        return Quiz(currentQuestionIndex: i, quizModel: quiz().fetchNextQuestion(with: level ?? .beginner))
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) { [weak self] in
            guard let self else { return }
            if (GameViewModel.currentIndex < 19  ) {             // max thesi - 1 gia na doulepsei, QuizData.count - 1,quiz().data.count - 1
                GameViewModel.currentIndex = GameViewModel.currentIndex + 1
                self.levelIndex = self.levelIndex + 1
                self.resetTimer()
                self.model = GameViewModel.createGameModel(i: GameViewModel.currentIndex, level: self.currentLevel)
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
                levelPoints += CGFloat(model.quizModel.points)
            } else {
                model.quizModel.optionsList[index].isMatched = false
            }
            model.quizModel.optionsList[index].isSelected = true
            totalLevelPoints += CGFloat(model.quizModel.points)
            pressed = true
            model.quizModel.isUsed = true
            self.adjustLevel()
            self.nextQ()
        }
    }
    
    //MARK: Level funcs
    func adjustLevel() {
        switch levelAdjustmentProcess(level: self.currentLevel) {
        case .up:
            guard currentLevel != .master else { return }
            self.levelUp()
            self.islevelUp = true
        case .down:
            guard currentLevel != .beginner else { return }
            self.levelDown()
            self.islevelUp = false
        case .none:
            return
        }
        self.resetLevelComponents()
        self.resetLevelChangePopUp()
    }
    
    func levelAdjustmentProcess(level: GameLevels) -> LevelAdjustmentState {
        switch level {
        case .beginner:
            return self.innerLevelPointSystemProcess(minPoints: 0.0, maxPoints: totalLevelPoints * 0.33, trigger: levelIndex == 3)
        case .intermediate:
            return self.innerLevelPointSystemProcess(minPoints: totalLevelPoints * 0.6, maxPoints: totalLevelPoints * 0.7, trigger: levelIndex == 2)
        case .pro:
            return self.innerLevelPointSystemProcess(minPoints: totalLevelPoints * 0.75, maxPoints: totalLevelPoints * 0.8, trigger: levelIndex == 2)
        case .master:
            return self.innerLevelPointSystemProcess(minPoints: totalLevelPoints * 0.85, maxPoints: 1000000.0, trigger: levelIndex == 1)
        }
    }
    
    func innerLevelPointSystemProcess( minPoints: CGFloat, maxPoints: CGFloat, trigger: Bool) -> LevelAdjustmentState {
        guard trigger else { return .none }
        if CGFloat(earnedPoints) <= minPoints {
            return .down
        } else if CGFloat(earnedPoints) >= maxPoints {
            return .up
        } else {
            return .none
        }
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
            break
        }
        self.hasChangedLevel = true
    }
    
    func levelDown() {
        switch currentLevel {
        case .beginner:
            break
        case .intermediate:
            self.currentLevel = .beginner
        case .pro:
            self.currentLevel = .intermediate
        case .master:
            self.currentLevel = .pro
        }
        self.hasChangedLevel = true
    }
    
    func resetLevelComponents() {
        levelPoints = 0
        //totalLevelPoints = 0
        levelIndex = 0
    }
    
    func resetLevelChangePopUp() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [weak self] in
            guard let self else { return }
            self.hasChangedLevel = false
        })
    }
}
