//
//  QnAResponse.swift
//  Kwizzles
//
//  Created by Bill on 11/3/23.
//

import Foundation


struct QnAResponse: Decodable {
    let quiz: [QuizJsonData]?
    
}

struct QuizJsonData: Decodable {
    let question: String?
    let answer: String?
    let options: [OptionItems]?
    let points: Int
    let level: String?
}

struct OptionItems: Decodable {
    let id: Int?
    let optionId: String?
    let option: String?
}
