//
//  CardLayoutStackView.swift
//  Pexeso
//
//  Created by Martin Kuchar on 2020-05-27.
//

import UIKit

class CardLayoutStackView: UIStackView {
    var arrayOfCards = Deck()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView() {
        arrayOfCards.deck.shuffle()
        print(arrayOfCards.deck)
        
        for index in 0...3 {
            let image = UIImage(named: arrayOfCards.deck[index].kind.rawValue)
            let imageView = UIImageView(image: image)
            imageView.constraintHeight(equalToConstant: 144)
            imageView.constraintWidth(equalToConstant: 86)
            self.addArrangedSubview(imageView)

        }
//        let imageView = UIImageView(image: UIImage(named: "Card_00"))
//        imageView.constraintHeight(equalToConstant: 144)
//        imageView.constraintWidth(equalToConstant: 86)
//        let imageView1 = UIImageView(image: UIImage(named: "Card_00"))
//        imageView1.constraintHeight(equalToConstant: 144)
//        imageView1.constraintWidth(equalToConstant: 86)
//        let imageView2 = UIImageView(image: UIImage(named: "Card_00"))
//        imageView2.constraintHeight(equalToConstant: 144)
//        imageView2.constraintWidth(equalToConstant: 86)
        
        
//        self.addArrangedSubview(imageView1)
//        self.addArrangedSubview(imageView2)
        
        self.axis = .horizontal
        self.distribution = .equalSpacing
        self.spacing = 20
        
    }
}
