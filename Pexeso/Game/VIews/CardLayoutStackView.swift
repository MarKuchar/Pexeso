import UIKit

class CardLayoutStackView: UIStackView {
    
    var arrayOfCards = Deck()
    
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
            btn.addTarget(self, action: #selector(cardTapped(_:)), for: .allEvents)
            btn.constraintHeight(equalToConstant: 126)
            btn.constraintWidth(equalToConstant: 75)
            hStack.addArrangedSubview(btn)
        }
        
        for index in 4...7 {
            let btn = UIButton()
            btn.setImage(UIImage(named: "Card_Back"), for: .normal)
            btn.tag = arrayOfCards.deck[index].kind.rawValue
            btn.addTarget(self, action: #selector(cardTapped(_:)), for: .allEvents)
            btn.constraintHeight(equalToConstant: 126)
            btn.constraintWidth(equalToConstant: 75)
            hStack1.addArrangedSubview(btn)
        }
        
        for index in 8...11 {
            let btn = UIButton()
            btn.setImage(UIImage(named: "Card_Back"), for: .normal)
            btn.tag = arrayOfCards.deck[index].kind.rawValue
            btn.addTarget(self, action: #selector(cardTapped(_:)), for: .allEvents)
            btn.constraintHeight(equalToConstant: 126)
            btn.constraintWidth(equalToConstant: 75)
            hStack2.addArrangedSubview(btn)
        }
        
        for index in 12...15 {
            let btn = UIButton()
            btn.setImage(UIImage(named: "Card_Back"), for: .normal)
            btn.tag = arrayOfCards.deck[index].kind.rawValue
            btn.addTarget(self, action: #selector(cardTapped(_:)), for: .allEvents)
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
            case 1:
                sender.setImage(UIImage(named: "Card_01"), for: .normal)
            case 2:
                sender.setImage(UIImage(named: "Card_02"), for: .normal)
            case 3:
                sender.setImage(UIImage(named: "Card_03"), for: .normal)
            case 4:
                sender.setImage(UIImage(named: "Card_04"), for: .normal)
            case 5:
                sender.setImage(UIImage(named: "Card_05"), for: .normal)
            case 6:
                sender.setImage(UIImage(named: "Card_06"), for: .normal)
            case 7:
                sender.setImage(UIImage(named: "Card_07"), for: .normal)
            default:
                sender.setImage(UIImage(named: "Card_08"), for: .normal)
        }
    }
}
