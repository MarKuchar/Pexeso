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
        self.navigationItem.title = "Scores"
        let backBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelScoreView(_:)))
        self.navigationItem.leftBarButtonItem = backBarButton
    }
    
    @objc func cancelScoreView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
