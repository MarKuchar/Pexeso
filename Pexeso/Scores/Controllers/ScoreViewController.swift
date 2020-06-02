//
//  ScoreViewController.swift
//  Pexeso
//
//  Created by Martin Kuchar on 2020-05-26.
//

import UIKit

class ScoreViewController: UITableViewController {
    
    struct PropertyKeys {
        static let cell = "cell"
    }
    
    let list = ScoreList.instance.scores
    let DISPLAY_ROW_COUNT = 5
    override func viewDidLoad() {
        super.viewDidLoad()
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "Table_03")?.draw(in: self.view.bounds)
        
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)
        } else {
            UIGraphicsEndImageContext()
            debugPrint("Image not available")
        }
        
        setBody()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if list.count < DISPLAY_ROW_COUNT {
            return list.count
        }
        return DISPLAY_ROW_COUNT
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.backgroundView = UIView(frame: self.view.bounds)
        header.backgroundView?.backgroundColor = UIColor.clear
        header.textLabel?.textColor = UIColor.clear
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection
        section: Int) -> String? {
        return "Header"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.cell, for: indexPath)
        
        let row = self.list[indexPath.row]
        
        cell.textLabel?.text =  String(indexPath.row + 1) + ".  " + row.name + " " + String(row.value)
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont(name: "TimesNewRomanPS-ItalicMT", size: 20.0)!
        cell.backgroundColor = UIColor(named: "transparent")
        
        return cell
    }
    
    func setBody() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: PropertyKeys.cell)
        tableView.sectionHeaderHeight = CGFloat(150.0)
        tableView.separatorColor = UIColor.clear
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    @objc func cancelScoreView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
