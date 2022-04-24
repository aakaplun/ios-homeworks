//
//  TransitionViewController.swift
//  Navigation
//
//  Created by Andrey Kaplun on 18/04/2022.
//  Copyright © 2022 Andrey Kaplun. All rights reserved.
//

import UIKit
import SwiftUI

final class TransitionViewController: UIViewController {
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var imageViewWidthConstraint, imageViewHeightConstraint: NSLayoutConstraint?
    private var imageViewSizeConstraints: [NSLayoutConstraint] {
        return [imageViewWidthConstraint, imageViewHeightConstraint].compactMap({ $0 })
    }
    private var imageViewConstraints: [NSLayoutConstraint] {
        let centerXContstraint = self.imageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor)
        let centerYConstraint = self.imageView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)
        return [centerXContstraint, centerYConstraint]
    }
        
    private func setImageViewSizeConstraints() {
        guard let size = self.imageView.image?.size else { return }

        if !self.imageViewSizeConstraints.isEmpty { NSLayoutConstraint.deactivate(self.imageViewSizeConstraints) }

        let widthMultiplier, heightMultiplier: CGFloat
        let imageProportion = size.width / size.height
        let viewProportion = self.view.frame.width / self.view.frame.height
        if  imageProportion > viewProportion {
            widthMultiplier = 1
            heightMultiplier = viewProportion / imageProportion
        } else {
            widthMultiplier = imageProportion / viewProportion
            heightMultiplier = 1
        }

        self.imageViewWidthConstraint = self.imageView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: widthMultiplier)
        self.imageViewHeightConstraint = self.imageView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: heightMultiplier)
        NSLayoutConstraint.activate(self.imageViewSizeConstraints)
    }
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.tintColor = .systemBackground
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 40), forImageIn: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var closeButtonConstraints: [NSLayoutConstraint] {
        let topConstraint = self.closeButton.topAnchor.constraint(equalTo: self.imageView.topAnchor)
        let trailingConstraint = self.closeButton.trailingAnchor.constraint(equalTo: self.imageView.trailingAnchor)
        return [topConstraint, trailingConstraint]
    }
    
    private lazy var setup: Void = {
        self.view.addSubview(self.imageView)
        self.view.addSubview(self.closeButton)
        
        NSLayoutConstraint.activate(imageViewConstraints + closeButtonConstraints)
        self.setImageViewSizeConstraints()
        self.closeButton.addTarget(self, action: #selector(self.handleTouchButton), for: .touchUpInside)
    }()
        
    func setup(with image: UIImage) {
        self.imageView.image = image
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        _ = setup
        self.setImageViewSizeConstraints()
    }
    
    @objc private func handleTouchButton(sender: UIButton) {
        self.dismiss(animated: true)
    }

}
