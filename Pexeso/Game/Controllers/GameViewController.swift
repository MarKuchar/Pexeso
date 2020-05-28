//
//  GameViewController.swift
//  Pexeso
//
//  Created by Martin Kuchar on 2020-05-26.
//

import UIKit

class GameViewController: UIViewController {

    let cardLayout = CardLayoutStackView()
    
    let scoreLabel: UILabel = {
       let label = UILabel()
        label.text = "XXX"
        return label
    }()
    
    let mistakeLabel: UILabel = {
       let label = UILabel()
        label.text = "XXX"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "Table_02")?.draw(in: self.view.bounds)

        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)
        } else {
            UIGraphicsEndImageContext()
            debugPrint("Image not available")
         }

        view.addSubview(cardLayout)
        view.addSubview(scoreLabel)
        view.addSubview(mistakeLabel)
        
        scoreLabel.anchors(topAnchor: view.topAnchor, leadingAnchor: view.leadingAnchor,
                           trailingAnchor: view.trailingAnchor, bottomAnchor: view.bottomAnchor,
                           padding: UIEdgeInsets(top: 0, left: 50, bottom: -15, right: 0), size: .zero)
        
        cardLayout.centerXYin(view)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
}
