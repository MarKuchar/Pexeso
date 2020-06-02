//
//  Score.swift
//  Pexeso
//
//  Created by Administlator on 2020/06/02.
//

import Foundation

struct Score {
    var name: String
    var value: Int
}

struct ScoreResponse: Codable {
    let range: String
    let majorDimension: String
    let values: [[String]]
}
