//
//  QuizManager.swift
//  Kwizzles
//
//  Created by Bill on 11/3/23.
//

import Foundation

struct QuizManager {
    
    static let shared = QuizManager()
    
    func getDataFromJSON() -> QnAResponse {
        var response = QnAResponse(quiz: [])
        if let url = Bundle.main.url(forResource: "KwizzlesQnA1", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let jsondata = try? decoder.decode(QnAResponse.self, from: data) {
                response = jsondata
            }
        }
        return response
    }
}
