//
//  CardLayoutStackView.swift
//  Pexeso
//
//  Created by Martin Kuchar on 2020-05-27.
//

import UIKit

class CardLayoutStackView: UIStackView {
    
    var arrayOfCards = Deck()
    
    let hStack: UIStackView = {
       let hStack = UIStackView()
        hStack.axis = .vertical
        hStack.distribution = .equalSpacing
        hStack.spacing = 10
        return hStack
    }()
    
    let hStack1: UIStackView = {
       let hStack = UIStackView()
        hStack.axis = .vertical
        hStack.distribution = .equalSpacing
        hStack.spacing = 10
        return hStack
    }()
    
    let hStack2: UIStackView = {
       let hStack = UIStackView()
        hStack.axis = .vertical
        hStack.distribution = .equalSpacing
        hStack.spacing = 10
        return hStack
    }()
    
    let hStack3: UIStackView = {
       let hStack = UIStackView()
        hStack.axis = .vertical
        hStack.distribution = .equalSpacing
        hStack.spacing = 10
        return hStack
    }()

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
            imageView.constraintHeight(equalToConstant: 126)
            imageView.constraintWidth(equalToConstant: 75)
            hStack.addArrangedSubview(imageView)
        }
        
        for index in 4...7 {
            let image = UIImage(named: arrayOfCards.deck[index].kind.rawValue)
            let imageView = UIImageView(image: image)
            imageView.constraintHeight(equalToConstant: 126)
            imageView.constraintWidth(equalToConstant: 75)
            hStack1.addArrangedSubview(imageView)
        }
        
        for index in 8...11 {
            let image = UIImage(named: arrayOfCards.deck[index].kind.rawValue)
            let imageView = UIImageView(image: image)
            imageView.constraintHeight(equalToConstant: 126)
            imageView.constraintWidth(equalToConstant: 75)
            hStack2.addArrangedSubview(imageView)
        }
        
        for index in 12...15 {
            let image = UIImage(named: arrayOfCards.deck[index].kind.rawValue)
            let imageView = UIImageView(image: image)
            imageView.constraintHeight(equalToConstant: 144)
            imageView.constraintWidth(equalToConstant: 86)
            hStack3.addArrangedSubview(imageView)
        }
        
        self.addArrangedSubview(hStack)
        self.addArrangedSubview(hStack1)
        self.addArrangedSubview(hStack2)
//        self.addArrangedSubview(hStack3)
        self.axis = .horizontal
        self.distribution = .equalSpacing
        self.spacing = 10
        
    }
}
