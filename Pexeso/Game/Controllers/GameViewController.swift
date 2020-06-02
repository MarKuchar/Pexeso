//
//  GameViewController.swift
//  Pexeso
//
//  Created by Martin Kuchar on 2020-05-26.
//

import UIKit

class GameViewController: UIViewController {
    
    let cardLayout = CardLayoutStackView()
    let homeController = HomeViewController()
    
    // timer
    var timer = Timer()
    var isTimerRunning = false
    var counter = 0
    var seconds = 0
    var minutes = 0
    //timer
    var userName : String = ""
    var timeText : String = ""
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.constraintWidth(equalToConstant: 100)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Luminari-Regular", size: 30)
        return label
    }()
    
    var game: Game?
    
    let mistakeLabel: UILabel = {
        let label = UILabel()
        label.text = "Mistakes: 0"
        label.constraintWidth(equalToConstant: 100)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Luminari-Regular", size: 15)
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Score: 0"
        label.constraintWidth(equalToConstant: 100)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Luminari-Regular", size: 15)
        return label
    }()
    
    let scoreImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Paper_Label"))
        imageView.constraintHeight(equalToConstant: 60)
        imageView.constraintWidth(equalToConstant: 150)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let mistakeImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Paper_Label"))
        imageView.constraintHeight(equalToConstant: 60)
        imageView.constraintWidth(equalToConstant: 150)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let timerImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "TimeLabel"))
        imageView.constraintHeight(equalToConstant: 90)
        imageView.constraintWidth(equalToConstant: 390)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "Background")?.draw(in: self.view.bounds)
        
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)
        } else {
            UIGraphicsEndImageContext()
            debugPrint("Image not available")
        }
        
        cardLayout.controller = self
        
        view.addSubview(cardLayout)
        cardLayout.centerXYin(view)
        NSLayoutConstraint.activate([
            cardLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            cardLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)])
        
        
        setViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        homeController.homeView.nameField.text = userName
        
        //        timer
        if !isTimerRunning{
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
            isTimerRunning = true
        }
        //      timer
    }
    
    func setViews() {
        view.addSubview(scoreImageView)
        view.addSubview(mistakeImageView)
        view.addSubview(timerImageView)
        
        scoreImageView.addSubview(scoreLabel)
        mistakeImageView.addSubview(mistakeLabel)
        timerImageView.addSubview(timerLabel)
        
        scoreLabel.centerXYin(scoreImageView)
        mistakeLabel.centerXYin(mistakeImageView)
        timerLabel.centerXYin(timerImageView)
        
        
        NSLayoutConstraint.activate([
            scoreImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            scoreImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70)])
        
        NSLayoutConstraint.activate([
            mistakeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            mistakeImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70)])
        
        NSLayoutConstraint.activate([
            timerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            timerImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70)])
    }
    
    @objc func runTimer(){
        counter += 1
        seconds = counter % 60
        minutes = counter / 60
        timeText = String(format: "%02d:%02d", minutes, seconds)
        timerLabel.text = "\(userName)\(timeText)"
    }
}
