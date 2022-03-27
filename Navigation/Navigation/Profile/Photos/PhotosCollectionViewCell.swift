//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Andrey Kaplun on 14/03/2022.
//  Copyright © 2022 Andrey Kaplun. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.imageView)
        
        let topConstraint = self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        let bottomConstraint = self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        let leadingConstraint = self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        let trailingConstraint = self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        
        NSLayoutConstraint.activate([
            topConstraint, bottomConstraint,leadingConstraint, trailingConstraint
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    func setup(with image: UIImage) {
        self.imageView.image = image
    }
}
