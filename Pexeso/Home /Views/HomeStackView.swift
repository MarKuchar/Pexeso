import UIKit

class HomeStackView: UIStackView {
    
    
    
    let titleLabel: UILabel = {
       let label = UILabel()
       label.text = "Memory Cards"
        label.font = UIFont(name: "Luminari-Regular", size: 45)
       return label
    }()
    
   let nameField: UITextField = {
    let tF = UITextField()
    tF.placeholder = "Enter your name"
    tF.font = UIFont(name: "Luminari-Regular", size: 35)
    tF.textAlignment = .center
    return tF
    }()
    
    let startBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.isUserInteractionEnabled = true
        btn.tag = 0
        btn.setTitle("START", for: .normal)
        btn.titleLabel?.font =  UIFont(name:"Luminari-Regular", size: 20)
        btn.tintColor = .black
        return btn
    }()
    
    let scoreBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.isUserInteractionEnabled = true
        btn.setTitle("SCORES", for: .normal)
        btn.tag = 1
        btn.titleLabel?.font =  UIFont(name:"Luminari-Regular", size: 20)
        btn.tintColor = .black
        
           return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView() {
        self.axis = .vertical
        self.distribution = .equalSpacing
        self.spacing = 30
        self.alignment = .center
        self.addArrangedSubview(titleLabel)
        self.addArrangedSubview(nameField)
        self.addArrangedSubview(startBtn)
        self.addArrangedSubview(scoreBtn)
    }
}
