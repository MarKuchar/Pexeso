//
//  GameViewController.swift
//  Pexeso
//
//  Created by Martin Kuchar on 2020-05-26.
//

import UIKit

class GameViewController: UIViewController {

    var cardLayout = CardLayoutStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(cardLayout)
        
        cardLayout.centerXYin(view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
}
