//
//  AvatarView.swift
//  Navigation
//
//  Created by Andrey Kaplun on 30/03/2022.
//  Copyright © 2022 Andrey Kaplun. All rights reserved.
//

import UIKit

extension ProfileViewController {
    
    func expandAvatar() {        
        self.view.addSubview(self.avatarView)
        
        let margins = self.view.safeAreaLayoutGuide
        let avatarViewConstraints = [
            avatarView.topAnchor.constraint(equalTo: margins.topAnchor),
            avatarView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            avatarView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            avatarView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(avatarViewConstraints)
        
        let avatarImageView: UIImageView = {
            let photoView = UIImageView(image: #imageLiteral(resourceName: "cat.png"))
            photoView.layer.borderColor = UIColor.white.cgColor
            photoView.layer.borderWidth = 3
            photoView.layer.cornerRadius = 50
            photoView.clipsToBounds = true
            photoView.isUserInteractionEnabled = true
            photoView.translatesAutoresizingMaskIntoConstraints = false
            return photoView
        }()
        
        self.avatarView.addSubview(avatarImageView)
        
        let avatarImageViewTopConstraint = avatarImageView.topAnchor.constraint(equalTo: self.avatarView.topAnchor, constant: 16)
        let avatarImageViewHeightConstraint = avatarImageView.heightAnchor.constraint(equalToConstant: 100)
        let avatarImageViewLeadingConstraint = avatarImageView.leadingAnchor.constraint(equalTo: self.avatarView.leadingAnchor, constant: 16)
        let avatarImageViewWidthConstraint = avatarImageView.widthAnchor.constraint(equalToConstant: 100)
                
        let semitransparentView = UIView()
        semitransparentView.backgroundColor = .white
        semitransparentView.alpha = 0
        semitransparentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.avatarView.addSubview(semitransparentView)
        
        let semitransparentViewConstraints = [
            semitransparentView.topAnchor.constraint(equalTo: margins.topAnchor),
            semitransparentView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            semitransparentView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            semitransparentView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ]

        NSLayoutConstraint.activate([
            avatarImageViewTopConstraint,
            avatarImageViewHeightConstraint,
            avatarImageViewLeadingConstraint,
            avatarImageViewWidthConstraint
        ] + semitransparentViewConstraints )

        self.avatarView.layoutIfNeeded()
        
        let size = min(self.avatarView.frame.size.width, self.avatarView.frame.size.height)
        
        avatarImageViewHeightConstraint.constant = size
        avatarImageViewWidthConstraint.constant = size
        
        let avatarImageViewCenterXConstraint = avatarImageView.centerXAnchor.constraint(equalTo: self.avatarView.centerXAnchor)
        let avatarImageViewCenterYConstraint = avatarImageView.centerYAnchor.constraint(equalTo: self.avatarView.centerYAnchor)
        
        NSLayoutConstraint.deactivate([
            avatarImageViewTopConstraint,
            avatarImageViewLeadingConstraint
        ])
        
        NSLayoutConstraint.activate([
            avatarImageViewCenterXConstraint,
            avatarImageViewCenterYConstraint
            ] + semitransparentViewConstraints)
        
        self.avatarView.bringSubviewToFront(avatarImageView)
        let closeButton = UIButton(type: .close)
        closeButton.alpha = 0
        closeButton.setTitleColor(.systemBlue, for: .normal)
        closeButton.addTarget(self, action: #selector(self.closeButtonTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.addSubview(closeButton)

        UIView.animate(withDuration: 0.5, animations: {
            avatarImageView.layer.cornerRadius = 0
            semitransparentView.alpha = 0.5
            self.avatarView.layoutIfNeeded()
        }) { _ in
            let closeButtonConstraints = [
                closeButton.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
                closeButton.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor)
            ]
            NSLayoutConstraint.activate(closeButtonConstraints)
            avatarImageView.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.3) {
                closeButton.alpha = 1
                avatarImageView.layoutIfNeeded()
            }
        }
        
        self.collapseAvatarCode = {
            UIView.animate(withDuration: 0.3, animations: {
                closeButton.alpha = 0
                self.avatarView.layoutIfNeeded()
            }) { _ in
                avatarImageViewHeightConstraint.constant = 100
                avatarImageViewWidthConstraint.constant = 100

                NSLayoutConstraint.deactivate([
                    avatarImageViewCenterXConstraint,
                    avatarImageViewCenterYConstraint
                ])
                                
                NSLayoutConstraint.activate([
                    avatarImageViewTopConstraint,
                    avatarImageViewLeadingConstraint
                ])
                
                UIView.animate(withDuration: 0.5, animations: {
                    avatarImageView.layer.cornerRadius = 50
                    semitransparentView.alpha = 0
                    self.avatarView.layoutIfNeeded()
                }) { _ in
                    avatarImageView.removeFromSuperview()
                    semitransparentView.removeFromSuperview()
                    self.avatarView.removeFromSuperview()
                    guard let profileHeaderView = self.tableView.headerView(forSection: 0) as? ProfileHeaderView else { return }
                    profileHeaderView.avatarImageView.isHidden = false
                }
            }
        }
    }
    
    private func collapseAvatar() {
        self.collapseAvatarCode()
    }
    
    @objc private func closeButtonTapped() {
        self.collapseAvatar()
    }
}
