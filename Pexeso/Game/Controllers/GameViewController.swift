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
