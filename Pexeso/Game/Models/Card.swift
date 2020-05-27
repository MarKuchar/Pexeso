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
    
    enum cardKind: String {
        case Card_00 = "Card_00", Card_01 = "Card_01", Card_02 = "Card_02", Card_03 = "Card_03", Card_04 = "Card_04", Card_05 = "Card_05"
    }
    
    init(kindOfCard: cardKind, isFlipped: Bool) {
        self.kind = kindOfCard
        self.isFlipped = isFlipped
    }
}
