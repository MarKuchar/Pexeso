import UIKit

class HomeViewController: UIViewController {
    var scoreList: ScoreList? = nil
    
    let homeView = HomeStackView()
    let userName : String = ""
    var scrollView : UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Table_01.jpg")
        backgroundImage.autoresizingMask = [UIView.AutoresizingMask.flexibleBottomMargin, UIView.AutoresizingMask.flexibleHeight, UIView.AutoresizingMask.flexibleTopMargin, UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleLeftMargin, UIView.AutoresizingMask.flexibleRightMargin]
        backgroundImage.contentMode = UIView.ContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        view.addSubview(homeView)
        homeView.centerXYin(view)
        registerForKayboardNotification()
        homeView.startBtn.addTarget(self, action: #selector(performSegue(_:)), for: .touchUpInside)
        homeView.scoreBtn.addTarget(self, action: #selector(performSegue(_:)), for: .touchUpInside)
            
    }
    private func registerForKayboardNotification (){
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
     }
     
     @objc func keyboardWasShown(_ notification: Notification){
         guard let info = notification.userInfo, let keyboardFrame = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else {return}
         
         let keyboardHeight  = keyboardFrame.cgRectValue.size.height
         let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        
     
         scrollView.contentInset = contentInsets
         scrollView.scrollIndicatorInsets = contentInsets
     }

     @objc func keyboardWillBeHidden(_ notification: Notification){
        let contentInsets = UIEdgeInsets.zero
         scrollView.contentInset  = contentInsets
         scrollView.scrollIndicatorInsets = contentInsets
     }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
     
    @objc func performSegue(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let gameController = GameViewController()
            
            if let userName = homeView.nameField.text, userName != "" {
                gameController.game = Game(name: userName)
            }else {
                print("Name is empty")
            }
            
            self.navigationController?.pushViewController(gameController, animated: true)
                       
        default:
            let scoreController = ScoreViewController()
            let navController = CustomNavigationController(rootViewController: scoreController)
            present(navController, animated: true, completion: nil)
        }
    }
}
