import UIKit

protocol FlipCardDelegate: class {
    func cardTapped(_ sender: UIButton)
}

class CardLayoutStackView: UIStackView {
    
    weak var delegate: FlipCardDelegate?
    var controller: GameViewController?
    
    var arrayOfCards = Deck()
    
    var flippedCards: [UIButton] = []
    
    let hStack: UIStackView = {
       let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.distribution = .equalSpacing
        hStack.spacing = 10
        return hStack
    }()
    
    let hStack1: UIStackView = {
       let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.distribution = .equalSpacing
        hStack.spacing = 10
        return hStack
    }()
    
    let hStack2: UIStackView = {
       let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.distribution = .equalSpacing
        hStack.spacing = 10
        return hStack
    }()
    
    let hStack3: UIStackView = {
       let hStack = UIStackView()
        hStack.axis = .horizontal
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
        
        for index in 0...3 {
            let btn = UIButton()
            btn.setImage(UIImage(named: "Card_Back"), for: .normal)
            btn.tag = arrayOfCards.deck[index].kind.rawValue
            btn.addTarget(self, action: #selector(cardTapped(_:)), for: .touchUpInside)
            btn.constraintHeight(equalToConstant: 126)
            btn.constraintWidth(equalToConstant: 75)
            hStack.addArrangedSubview(btn)
        }

        for index in 4...7 {
            let btn = UIButton()
            btn.setImage(UIImage(named: "Card_Back"), for: .normal)
            btn.tag = arrayOfCards.deck[index].kind.rawValue
            btn.addTarget(self, action: #selector(cardTapped(_:)), for: .touchUpInside)
            btn.constraintHeight(equalToConstant: 126)
            btn.constraintWidth(equalToConstant: 75)
            hStack1.addArrangedSubview(btn)
        }

        for index in 8...11 {
            let btn = UIButton()
            btn.setImage(UIImage(named: "Card_Back"), for: .normal)
            btn.tag = arrayOfCards.deck[index].kind.rawValue
            btn.addTarget(self, action: #selector(cardTapped(_:)), for: .touchUpInside)
            btn.constraintHeight(equalToConstant: 126)
            btn.constraintWidth(equalToConstant: 75)
            hStack2.addArrangedSubview(btn)
        }

        for index in 12...15 {
            let btn = UIButton()
            btn.setImage(UIImage(named: "Card_Back"), for: .normal)
            btn.tag = arrayOfCards.deck[index].kind.rawValue
            btn.addTarget(self, action: #selector(cardTapped(_:)), for: .touchUpInside)
            btn.constraintHeight(equalToConstant: 126)
            btn.constraintWidth(equalToConstant: 75)
            hStack3.addArrangedSubview(btn)
        }

        self.addArrangedSubview(hStack)
        self.addArrangedSubview(hStack1)
        self.addArrangedSubview(hStack2)
        self.addArrangedSubview(hStack3)

        self.axis = .vertical
        self.distribution = .equalSpacing
        self.spacing = 10
    }

    @objc func cardTapped(_ sender: UIButton) {
        switch sender.tag {
            case 0:
                sender.setImage(UIImage(named: "Card_00"), for: .normal)
                flippedCards.append(sender)
            case 1:
                sender.setImage(UIImage(named: "Card_01"), for: .normal)
                flippedCards.append(sender)
            case 2:
                sender.setImage(UIImage(named: "Card_02"), for: .normal)
                flippedCards.append(sender)
            case 3:
                sender.setImage(UIImage(named: "Card_03"), for: .normal)
                flippedCards.append(sender)
            case 4:
                sender.setImage(UIImage(named: "Card_04"), for: .normal)
                flippedCards.append(sender)
            case 5:
                sender.setImage(UIImage(named: "Card_05"), for: .normal)
                flippedCards.append(sender)
            case 6:
                sender.setImage(UIImage(named: "Card_06"), for: .normal)
                flippedCards.append(sender)
            case 7:
                sender.setImage(UIImage(named: "Card_07"), for: .normal)
                flippedCards.append(sender)
            default:
                sender.setImage(UIImage(named: "Card_08"), for: .normal)
                flippedCards.append(sender)
            }
        print(arrayOfCards.deck)
        if (flippedCards.count % 2 == 0 && flippedCards.count != 0) {
            compareCards()
        }
    }
    
    func compareCards() {
        sleep(2)
        if flippedCards[0].tag == flippedCards[1].tag {
// Make an animation both cards to the middle and than disapear
            UIView.animate(withDuration: 1) {
            // For our information: if you want to hide UI.. in the stackView, instead of using .isHidden = true, we use .alpha = 0
                self.flippedCards[0].alpha = 0
                self.flippedCards[1].alpha = 0
            }
            if let c = controller {
                c.game!.match()
            }
        } else {
            
            self.flippedCards[0].setImage(UIImage(named: "Card_Back"), for: .normal)
            self.flippedCards[1].setImage(UIImage(named: "Card_Back"), for: .normal)
            if let c = controller {
                c.game!.miss()
                c.mistakeLabel.text = "Mistakes: " + String(c.game!.missCount)
            }
        }
        flippedCards.removeAll(keepingCapacity: true)
    }
}
