import UIKit

class HomeViewController: UIViewController {
    
    @objc func performSegue(_ sender: UIButton) {
        print("tapped")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeView = HomeStackView()
        view.addSubview(homeView)
        homeView.centerXYin(view)
        
        homeView.startBtn.addTarget(self, action: #selector(performSegue(_:)), for: .touchUpInside)
    }
}

