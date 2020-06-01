//
//  GameViewController.swift
//  Pexeso
//
//  Created by Martin Kuchar on 2020-05-26.
//

import UIKit

class GameViewController: UIViewController, FlipCardDelegate {
    
    @objc func cardTapped(_ sender: UIButton) {
       switch sender.tag {
           case 0:
               sender.setImage(UIImage(named: "Card_00"), for: .normal)
           case 1:
               sender.setImage(UIImage(named: "Card_01"), for: .normal)
           case 2:
               sender.setImage(UIImage(named: "Card_02"), for: .normal)
           case 3:
               sender.setImage(UIImage(named: "Card_03"), for: .normal)
           case 4:
               sender.setImage(UIImage(named: "Card_04"), for: .normal)
           case 5:
               sender.setImage(UIImage(named: "Card_05"), for: .normal)
           case 6:
               sender.setImage(UIImage(named: "Card_06"), for: .normal)
           case 7:
               sender.setImage(UIImage(named: "Card_07"), for: .normal)
           default:
               sender.setImage(UIImage(named: "Card_08"), for: .normal)
       }
    
    }
    
    let cardLayout = CardLayoutStackView()
    
    let mistakeLabel: UILabel = {
       let label = UILabel()
        label.text = "Mistakes:"
        label.constraintWidth(equalToConstant: 100)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let scoreLabel: UILabel = {
       let label = UILabel()
        label.text = "Score:"
        label.constraintWidth(equalToConstant: 100)
        label.translatesAutoresizingMaskIntoConstraints = false
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
        
        view.addSubview(cardLayout)
        cardLayout.centerXYin(view)
        NSLayoutConstraint.activate([
            cardLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            cardLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35)])
        
        setViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func setViews() {
        view.addSubview(scoreImageView)
        view.addSubview(mistakeImageView)
        
        scoreImageView.addSubview(scoreLabel)
        mistakeImageView.addSubview(mistakeLabel)
        
        scoreLabel.centerXYin(scoreImageView)
        mistakeLabel.centerXYin(mistakeImageView)

        NSLayoutConstraint.activate([
            scoreImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            scoreImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70)])
        
        NSLayoutConstraint.activate([
            mistakeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            mistakeImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70)])
    }
    
    
}
