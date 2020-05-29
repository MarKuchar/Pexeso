//
//  Card.swift
//  Pexeso
//
//  Created by Martin Kuchar on 2020-05-27.
//

import Foundation

struct Card {
    
    var isFlipped: Bool
    
    var kind: cardKind
    
    enum cardKind: Int {
        case Card_00 = 0, Card_01 = 1, Card_02 = 2,
        Card_03 = 3, Card_04 = 4, Card_05 = 5,
        Card_06 = 6, Card_07 = 7
    }
    
    init(kindOfCard: cardKind, isFlipped: Bool) {
        self.kind = kindOfCard
        self.isFlipped = isFlipped
    }
}
