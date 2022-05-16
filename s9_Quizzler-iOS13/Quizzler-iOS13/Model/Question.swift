//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by Ray WU on 14/05/2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct Question {
    let question: String
    let answer: String

    init(q: String, a: String) {
        question = q
        answer = a
    }
}

