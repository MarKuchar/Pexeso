import UIKit

class HomeStackView: UIStackView {
    
    let titleLabel: UILabel = {
       let label = UILabel()
       label.text = "Memory Cards"
       return label
    }()
    
    let nameField: UITextField = {
       let tF = UITextField()
       tF.placeholder = "Enter your name"
       return tF
    }()
    
    let startBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.isUserInteractionEnabled = true
        btn.tag = 0
        btn.setTitle("START", for: .normal)
        return btn
    }()

    let scoreBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.isUserInteractionEnabled = true
        btn.tag = 1
        btn.setTitle("Scores", for: .normal)
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
        self.spacing = 20
        self.alignment = .center
        self.addArrangedSubview(titleLabel)
        self.addArrangedSubview(nameField)
        self.addArrangedSubview(startBtn)
        self.addArrangedSubview(scoreBtn)
    }
}