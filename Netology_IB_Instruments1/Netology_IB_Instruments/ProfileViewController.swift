//
//  ProfileViewController.swift
//  Netology_IB_Instruments
//
//  Created by Andrey Kaplun on 09/02/2022.
//  Copyright © 2022 Andrey Kaplun. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if let subview = Bundle.main.loadNibNamed("ProfileView", owner: self, options: nil)?.first as? UIView {
            self.view.addSubview(subview)
            subview.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        }
    }
}
