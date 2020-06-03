//
//  GameViewController.swift
//  Pexeso
//
//  Created by Martin Kuchar on 2020-05-26.
//

import UIKit

class GameViewController: UIViewController, FlipCardDelegate {
    
    let cardLayout = CardLayoutStackView()
    let homeController = HomeViewController()
    
    // timer
    var timer = Timer()
    var isTimerRunning = false
    var counter = 0
    var seconds = 0
    var minutes = 0
    var timeText : String = ""
    //timer
    
    var notificationWidthConstraint: NSLayoutConstraint!
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Luminari-Regular", size: 30)
        return label
    }()
    
    var game: Game?
    
    let mistakeLabel: UILabel = {
        let label = UILabel()
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
    
    let notificationLabel: UILabel = {
        let label = UILabel()
        label.text = "START"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Luminari-Regular", size: 30)
        return label
    }()
    
    let notificationImageView: UIImageView = {
       let imageView = UIImageView(image: UIImage(named: "Notification_01"))
       imageView.translatesAutoresizingMaskIntoConstraints = false
       imageView.contentMode = .scaleAspectFit
       imageView.clipsToBounds = true
       return imageView
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
        imageView.constraintHeight(equalToConstant: 80)
        imageView.constraintWidth(equalToConstant: 345)
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
        
        cardLayout.delegate = self
        
        notification("Start")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        homeController.homeView.nameField.text = game!.name
        
        // init label
        scoreLabel.text = "Score: " + String(game!.matchCount)
        mistakeLabel.text = "Mistakes: " + String(game!.missCount)
        game!.cardCount = cardLayout.arrayOfCards.deck.count
        
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
        view.addSubview(notificationImageView)
        
        scoreImageView.addSubview(scoreLabel)
        mistakeImageView.addSubview(mistakeLabel)
        timerImageView.addSubview(timerLabel)
        notificationImageView.addSubview(notificationLabel)
        
        scoreLabel.centerXYin(scoreImageView)
        mistakeLabel.centerXYin(mistakeImageView)
        NSLayoutConstraint.activate([
        notificationLabel.centerYAnchor.constraint(equalTo: notificationImageView.centerYAnchor, constant: -13),
        notificationLabel.centerXAnchor.constraint(equalTo: notificationImageView.centerXAnchor)])
        NSLayoutConstraint.activate([
        timerLabel.centerYAnchor.constraint(equalTo: timerImageView.centerYAnchor, constant: -10),
        timerLabel.centerXAnchor.constraint(equalTo: timerImageView.centerXAnchor)])

       
        NSLayoutConstraint.activate([
            scoreImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            scoreImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70)])
        NSLayoutConstraint.activate([
            mistakeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            mistakeImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70)])
        NSLayoutConstraint.activate([
            timerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            timerImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            timerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)])
        notificationImageView.centerXYin(view)
        
        self.notificationWidthConstraint = notificationImageView.widthAnchor.constraint(equalToConstant: 250)
        NSLayoutConstraint.activate([notificationWidthConstraint])
    }
    
    func updateLabel() {
        scoreLabel.text = "Score: " + String(game!.value)
        mistakeLabel.text = "Mistakes: " + String(game!.missCount)
    }
    
    @objc func runTimer(){
        if (game!.isFinished()) {
            game?.finish()
            updateLabel()
            isTimerRunning = false
            timer.invalidate()
            return
        }
        counter += 1
        seconds = counter % 60
        minutes = counter / 60
        
        game!.setRemain(time: counter)
        timeText = String(format: "%02d:%02d", minutes, seconds)
        timerLabel.text = "\(game!.name) \(timeText)"
    }
    
    func notification(_ type: String) {
        switch type {
            case "Start":
                UIView.animate(withDuration: 3, animations: {
                    self.notificationImageView.alpha = 0
                })
            case "Match":
                UIView.animate(withDuration: 2, animations: {
                    self.notificationLabel.text = "MATCH"
                    self.notificationImageView.alpha = 0.8
                }, completion: ((Bool) -> Void)? { _ in
                    UIView.animate(withDuration: 1, animations: {
                        self.notificationImageView.alpha = 0
                    })
                    self.notificationImageView.alpha = 0
                })
            case "Miss":
                UIView.animate(withDuration: 1, animations: {
                        self.notificationLabel.text = "MISS"
                    self.notificationImageView.alpha = 0.5
                    }, completion: ((Bool) -> Void)? { _ in
                        UIView.animate(withDuration: 1, animations: {
                            self.notificationImageView.alpha = 0
                        })
                    })
            default:
                UIView.animate(withDuration: 6, delay: 3,animations: {
                    self.notificationLabel.text = "MATCH"
                    self.notificationImageView.alpha = 1
                }, completion: ((Bool) -> Void)? { _ in
                    UIView.animate(withDuration: 4, animations: {
                        self.view.layoutIfNeeded()
                        NSLayoutConstraint.deactivate([
                            self.notificationWidthConstraint])
                        NSLayoutConstraint.activate([
                            self.notificationImageView.widthAnchor.constraint(equalToConstant: 360)])
                            self.notificationLabel.text = "Total score: \(self.game!.value)"
                    })
                })
        }
    }
}
