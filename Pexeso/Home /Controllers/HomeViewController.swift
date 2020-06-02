import UIKit

class HomeViewController: UIViewController {
    var scoreList: ScoreList? = nil
        
    let homeView = HomeStackView()
    let userName : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
               backgroundImage.image = UIImage(named: "Table_01.jpg")
               backgroundImage.autoresizingMask = [UIView.AutoresizingMask.flexibleBottomMargin, UIView.AutoresizingMask.flexibleHeight, UIView.AutoresizingMask.flexibleTopMargin, UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleLeftMargin, UIView.AutoresizingMask.flexibleRightMargin]
        backgroundImage.contentMode = UIView.ContentMode.scaleToFill
               self.view.insertSubview(backgroundImage, at: 0)

        view.addSubview(homeView)
        homeView.centerXYin(view)
        
        homeView.startBtn.addTarget(self, action: #selector(performSegue(_:)), for: .touchUpInside)
        homeView.scoreBtn.addTarget(self, action: #selector(performSegue(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func performSegue(_ sender: UIButton) {
        switch sender.tag {
            case 0:
                let gameController = GameViewController()
                gameController.game = Game(name: userName)
                guard let userName = homeView.nameField.text, userName != "" else {
                        print("Name is empty")
                        return
                }
                self.navigationController?.pushViewController(gameController, animated: true)
        
                
            default:
                let scoreController = ScoreViewController()
                let navController = CustomNavigationController(rootViewController: scoreController)
                present(navController, animated: true, completion: nil)
        }
    }
}

