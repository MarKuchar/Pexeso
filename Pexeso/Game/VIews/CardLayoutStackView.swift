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
            flip(sender, image: "Card_00")
            flippedCards.append(sender)
        case 1:
            flip(sender, image: "Card_01")
            flippedCards.append(sender)
        case 2:
            flip(sender, image: "Card_02")
            flippedCards.append(sender)
        case 3:
            flip(sender, image: "Card_03")
            flippedCards.append(sender)
        case 4:
            flip(sender, image: "Card_04")
            flippedCards.append(sender)
        case 5:
            flip(sender, image: "Card_05")
            flippedCards.append(sender)
        case 6:
            flip(sender, image: "Card_06")
            flippedCards.append(sender)
        default:
            flip(sender, image: "Card_07")
            flippedCards.append(sender)
        }
        print(arrayOfCards.deck)
        if ( flippedCards.count >= 2 && flippedCards.count % 2 == 0) {
            compareCards()
        }
    }
    
    func compareCards() {
        let previous = flippedCards[flippedCards.count - 1]
        let current = flippedCards[flippedCards.count - 2]
        if current.tag == previous.tag {
            UIView.animate(withDuration: 2.0, delay: 2.0, options: .transitionFlipFromRight, animations: {
                // let currentFrame = self.flippedCards[0].layer.presentation()!.frame
                previous.superview?.bringSubviewToFront(self.flippedCards[0])
                previous.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                current.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                current.superview?.bringSubviewToFront(self.flippedCards[0])
                
            }, completion: ((Bool) -> Void)? { _ in
                
                // For our information: if you want to hide UI.. in the stackView, instead of using .isHidden = true, we use .alpha = 0
                UIView.animate(withDuration: 2.0, animations: {
                    previous.alpha = 0
                    current.alpha = 0
                })
                
                }
            )
            controller!.game!.match()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.flip(previous, image: "Card_Back")
                self.flip(current, image: "Card_Back")
            }
            
            controller!.game!.miss()
        }
        
        controller!.updateLabel()
    }
    
    func flip(_ button: UIButton, image: String) {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        UIView.transition(with: button, duration: 1.0, options: transitionOptions, animations: {
            button.setImage(UIImage(named: image), for: .normal)
        })
    }
}
