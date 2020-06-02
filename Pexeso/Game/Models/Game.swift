//
//  Game.swift
//  Pexeso
//
//  Created by Administlator on 2020/06/02.
//

import Foundation
let TIME_LIMIT = 3000

class Game {
    var name: String
    var cardCount: Int = 0
    var value: Int = 0
    var matchCount = 0
    var missCount = 0
    var remain = TIME_LIMIT
    
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
    
    func setRemain(time: Int) {
        let _remain = TIME_LIMIT  - time
        if (_remain <= 0) {
            self.remain = 0
            return
        }
        self.remain = _remain
    }
    
    func isFinished() -> Bool {
        if (remain <= 0) {
            return true
        }
        return matchCount >= (cardCount / 2)
    }
    
    private func calcScore() {
        let num = matchCount * 10 - missCount * 2
        if (num < 0) {
            value = 0
            return
        }
        value = num
    }
    
    private func calcBonus() {
        if remain >= 1800 {
            value += 100
            return
        }
        if remain >= 600 {
            value += 50
            return
        }
    }
}
