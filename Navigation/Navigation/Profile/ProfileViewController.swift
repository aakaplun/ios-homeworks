//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Andrey Kaplun on 10/02/2022.
//  Copyright © 2022 Andrey Kaplun. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profileHeaderView = ProfileHeaderView(frame: .zero)
        
        self.view.addSubview(profileHeaderView)
        profileHeaderView.backgroundColor = .lightGray
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        let margins = self.view.safeAreaLayoutGuide
        let topConstraint = profileHeaderView.topAnchor.constraint(equalTo: margins.topAnchor)
        //let bottomConstraint = profileHeaderView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        let leadingConstraint = profileHeaderView.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = profileHeaderView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        let hightConstraint = profileHeaderView.heightAnchor.constraint(equalToConstant: 220)
        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, hightConstraint])
        
        // Непонятная кнопочка...
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.backgroundColor = .systemBlue
        button.titleLabel?.textColor = .white
        button.setTitle("Button", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(button)
        let buttonLeadingConstraint = button.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let buttonTrailingConstraint = button.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        let buttonHeightContraint = button.heightAnchor.constraint(equalToConstant: 50)
        let buttonBottomConstraint = button.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        NSLayoutConstraint.activate([buttonLeadingConstraint, buttonTrailingConstraint, buttonHeightContraint, buttonBottomConstraint])
    }
}
