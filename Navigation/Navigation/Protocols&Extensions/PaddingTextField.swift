//
//  PaddingTextField.swift
//  Navigation
//
//  Created by Andrey Kaplun on 20/02/2022.
//  Copyright © 2022 Andrey Kaplun. All rights reserved.
//

import UIKit

class PaddingTextField: UITextField {
    private var leftInset: Int = 5
    private var rightInset: Int = 15
    
    private var padding: UIEdgeInsets {
        UIEdgeInsets(top: 0, left: CGFloat(leftInset), bottom: 0, right: CGFloat(rightInset))
    }
    
    convenience init(withLeftInset leftInset: Int, rightInset: Int = 15) {
        self.init()
        self.leftInset = leftInset
        self.rightInset = rightInset
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
