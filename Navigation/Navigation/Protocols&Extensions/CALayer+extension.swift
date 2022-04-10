//
//  CALayer+extension.swift
//  Navigation
//
//  Created by Andrey Kaplun on 09/04/2022.
//  Copyright © 2022 Andrey Kaplun. All rights reserved.
//

import UIKit

extension CALayer {
    func animateBorder(with color: UIColor, width: Float) {
        let colorAnimation = CABasicAnimation(keyPath: "color")
        colorAnimation.fromValue = self.borderColor
        colorAnimation.toValue = color.cgColor
        colorAnimation.duration = 2
        colorAnimation.repeatCount = 1
        CATransaction.begin()
        self.add(colorAnimation, forKey: "color")
        CATransaction.commit()
        
    }
}
