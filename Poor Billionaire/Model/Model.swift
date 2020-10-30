//
//  Model.swift
//  Poor Billionaire
//
//  Created by Ulvi Bashirov on 10/21/20.
//

import Foundation

struct Result: Codable {
    let responseCode: Int
    let results: [Question]

    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results
    }
}

struct Question: Codable {
    let category: String?
    let type: String?
    let difficulty: String?
    var question, correctAnswer: String?
    var answers: [String]?

    enum CodingKeys: String, CodingKey {
        case category, type, difficulty, question
        case correctAnswer = "correct_answer"
        case answers = "incorrect_answers"
    }
}

enum Difficulty: String {
    case easy, medium, hard
}
