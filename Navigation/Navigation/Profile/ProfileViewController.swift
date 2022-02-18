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
        
        let profileHeaderView = ProfileHeaderView(frame: self.view.frame)
        self.view.addSubview(profileHeaderView)
        profileHeaderView.backgroundColor = .lightGray
        
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        let margins = self.view.safeAreaLayoutGuide
        let topConstraint = profileHeaderView.topAnchor.constraint(equalTo: margins.topAnchor)
        let bottomConstraint = profileHeaderView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        let leadingConstraint = profileHeaderView.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = profileHeaderView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        NSLayoutConstraint.activate([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
