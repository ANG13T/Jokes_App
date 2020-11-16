//
//  Question.swift
//  JokesApp
//
//  Created by Angelina Tsuboi on 11/16/20.
//

import Foundation

struct Question: Codable{
    var question: String
    var correct_answer = ""
    var category: String
}
