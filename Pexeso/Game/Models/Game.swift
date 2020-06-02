//
//  Game.swift
//  Pexeso
//
//  Created by Administlator on 2020/06/02.
//

import Foundation

class Game {
    var name: String
    var value: Int = 0
    var matchCount = 0
    var missCount = 0
    var timer = 5000
    
    init(name: String) {
        self.name = name
    }
    
    func match() {
        matchCount += 1
        calcScore()
    }
    
    func miss() {
        missCount += 1
        calcScore()
    }
    
    func finish() {
        calcBonus()
        ScoreList.instance.putAndReplace(item: Score(name: name, value: value))
    }
    
    private func calcScore() {
        let num = matchCount * 10 - missCount * 5
        if (num < 0) {
            value = 0
            return
        }
        value = num
    }
    
    private func calcBonus() {
        if timer >= 4000 {
            value += 100
        }
        if timer >= 1000 {
            value += 50
        }
    }
}
