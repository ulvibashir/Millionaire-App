//
//  ViewController.swift
//  Poor Billionaire
//
//  Created by Ulvi Bashirov on 10/21/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var background: UIView!
    @IBOutlet weak var startButton: UIButton! {
        didSet {
            startButton.layer.cornerRadius = 25
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradientLayer()
    }
    
    func addGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.background.bounds

        let colorTop = UIColor.purple.cgColor
        let colorBottom = UIColor.black.cgColor

        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        self.background.layer.addSublayer(gradientLayer)
        self.background.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    

}

