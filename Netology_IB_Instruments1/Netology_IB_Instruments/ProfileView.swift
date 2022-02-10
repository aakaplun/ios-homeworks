//
//  ProfileView.swift
//  Netology_IB_Instruments
//
//  Created by Andrey Kaplun on 09/02/2022.
//  Copyright © 2022 Andrey Kaplun. All rights reserved.
//

import UIKit

class ProfileView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    private func setupView() {
        let view = self.loadViewFromXib()
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }
    
    private func loadViewFromXib() -> UIView {
        guard let view = Bundle.main.loadNibNamed("ProfileView", owner: self, options: nil)?.first as? UIView else {return UIView() }
        return view
    }

}
