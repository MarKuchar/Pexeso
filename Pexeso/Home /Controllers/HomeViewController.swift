import UIKit

class HomeViewController: UIViewController {
    
//    timer
    var timer = Timer()
    var isTimerRunning = false
    var counter = 0.0
    let timerLabel = UILabel()
//    timer
    
    var scoreList: ScoreList? = nil
        
    override func viewDidLoad() {
 super.viewDidLoad()
         
         let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
         backgroundImage.image = UIImage(named: "Table_01.jpg")
         backgroundImage.autoresizingMask = [UIView.AutoresizingMask.flexibleBottomMargin, UIView.AutoresizingMask.flexibleHeight, UIView.AutoresizingMask.flexibleTopMargin, UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleLeftMargin, UIView.AutoresizingMask.flexibleRightMargin]
         backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
         self.view.insertSubview(backgroundImage, at: 0)        
       
         let homeView = HomeStackView()
         view.addSubview(homeView)
         homeView.centerXYin(view)
        
        homeView.startBtn.addTarget(self, action: #selector(performSegue(_:)), for: .touchUpInside)
        homeView.scoreBtn.addTarget(self, action: #selector(performSegue(_:)), for: .touchUpInside)
        
        scoreList = ScoreList.instance
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func performSegue(_ sender: UIButton) {
        switch sender.tag {
            case 0:
                let gameController = GameViewController()
                self.navigationController?.pushViewController(gameController, animated: true)
                
//                timer
                if !isTimerRunning{
                    timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
                    isTimerRunning = true
                }
           
//            timer
            
            
            default:
                let scoreController = ScoreViewController()
                let navController = CustomNavigationController(rootViewController: scoreController)
                navController.navigationItem.title = "Scores"             
                present(navController, animated: true, completion: nil)
        }
    }
    @objc func runTimer(){
        counter += 0.1
        timerLabel.text = "\(counter)"
           }
}

