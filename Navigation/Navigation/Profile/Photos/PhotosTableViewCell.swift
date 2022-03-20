//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Andrey Kaplun on 14/03/2022.
//  Copyright © 2022 Andrey Kaplun. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private lazy var photosLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.text = "Photos"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func photosLabelConstraints() -> [NSLayoutConstraint] {
        let topContraint = self.photosLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12)
        let leadingConstraint = self.photosLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12)
        return [topContraint, leadingConstraint]
    }
    
    private lazy var arrowImageView: UIImageView = {
        let image = UIImage(systemName: "arrow.right")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func arrowImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = arrowImageView.centerYAnchor.constraint(equalTo: self.photosLabel.centerYAnchor)
        let trailingConstraint = arrowImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12)
        return [centerYConstraint, trailingConstraint]
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func stackViewConstraints() -> [NSLayoutConstraint] {
        let topContraint = self.stackView.topAnchor.constraint(equalTo: self.photosLabel.bottomAnchor, constant: 12)
        let leadingConstraint = self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12)
        let trailingConstraint = self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12)
        let height = (self.contentView.bounds.width - 48) / 4
        let heightContraint = self.stackView.heightAnchor.constraint(equalToConstant: height)
        let bottomContraint = self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12)
        return [topContraint, leadingConstraint, trailingConstraint, heightContraint, bottomContraint]
    }
    
    private lazy var photoImageViews: [UIImageView] = {
        var imageViews = [UIImageView]()
        for i in 1...4 {
            let name = "Photo" + String(i)
            let image = UIImage(named: name)
            let imageView = UIImageView(image: image)
            imageView.layer.cornerRadius = 6
            imageView.clipsToBounds = true
            imageViews.append(imageView)
        }
        return imageViews
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupView() {
        self.contentView.addSubview(self.photosLabel)
        self.contentView.addSubview(self.arrowImageView)
        self.contentView.addSubview(self.stackView)
        self.photoImageViews.forEach { (imageView) in
            self.stackView.addArrangedSubview(imageView)
        }
        
        let photosLabelConstraints = self.photosLabelConstraints()
        let arrowImageViewConstraints = self.arrowImageViewConstraints()
        let stackViewConstraints = self.stackViewConstraints()
        
        NSLayoutConstraint.activate(photosLabelConstraints + arrowImageViewConstraints + stackViewConstraints)
    }
}
