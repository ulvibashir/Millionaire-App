//
//  Gradient.swift
//  Poor Billionaire
//
//  Created by Ulvi Bashirov on 10/21/20.
//

import Foundation
import UIKit

struct BCgradient {
    
    func getGradient() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = self.background.bounds

        let colorTop = UIColor.purple.cgColor
        let colorBottom = UIColor.black.cgColor

        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)

//        self.background.layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }
}
