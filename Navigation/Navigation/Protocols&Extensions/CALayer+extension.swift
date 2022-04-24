//
//  CALayer+extension.swift
//  Navigation
//
//  Created by Andrey Kaplun on 09/04/2022.
//  Copyright © 2022 Andrey Kaplun. All rights reserved.
//

import UIKit

extension CALayer {
    func animateBorder(with color: UIColor, width: CGFloat) {
        let duration: CFTimeInterval = 0.2
        let repeatCount: Float = 1

        let colorAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.borderColor))
        colorAnimation.fromValue = self.borderColor
        colorAnimation.toValue = color.cgColor
        colorAnimation.duration = duration
        colorAnimation.repeatCount = repeatCount
        colorAnimation.autoreverses = true
        
        let widthAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.borderWidth))
        widthAnimation.fromValue = self.borderWidth
        widthAnimation.toValue = width
        colorAnimation.duration = duration
        colorAnimation.repeatCount = repeatCount
        colorAnimation.autoreverses = true
        
        CATransaction.begin()
        self.add(colorAnimation, forKey: #keyPath(CALayer.borderColor))
        self.add(widthAnimation, forKey: #keyPath(CALayer.borderWidth))
        CATransaction.commit()
    }
}
