//
//  ScoreViewController.swift
//  Pexeso
//
//  Created by Martin Kuchar on 2020-05-26.
//

import UIKit

class ScoreViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.title = "Scores"
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "Table_03")?.draw(in: self.view.bounds)
        
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)
        } else {
            UIGraphicsEndImageContext()
            debugPrint("Image not available")
         }
        
//        let backBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelScoreView(_:)))
//        self.navigationItem.leftBarButtonItem = backBarButton
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    
    @objc func cancelScoreView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
