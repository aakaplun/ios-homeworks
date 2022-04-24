//
//  DetailViewController.swift
//  Navigation
//
//  Created by Andrey Kaplun on 16/04/2022.
//  Copyright © 2022 Andrey Kaplun. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private func scrollViewConstraints() -> [NSLayoutConstraint] {
        let layoutGuide = self.view.safeAreaLayoutGuide
        let topConstraint = self.scrollView.topAnchor.constraint(equalTo: layoutGuide.topAnchor)
        let leadingConstraint = self.scrollView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor)
        let trailingConstraint = self.scrollView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor)
        let bottomConstraint = self.scrollView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor)
        
        let contentHeightConstraint = self.scrollView.contentLayoutGuide.heightAnchor.constraint(equalTo: self.contentView.heightAnchor)
        let contentWidthConstraint = self.scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: self.contentView.widthAnchor)

        return [
            topConstraint, leadingConstraint, trailingConstraint, bottomConstraint,
            contentHeightConstraint, contentWidthConstraint
        ]
    }

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private func contentViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor)
        let centerXConstraint = self.contentView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        let widthConstraint = self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        return [topConstraint, centerXConstraint, widthConstraint]
    }

    private lazy var autorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .blue
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func autorLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.autorLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16)
        let leadingConstraint = self.autorLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        let trailingConstraint = self.autorLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        let heightConstraint = self.autorLabel.heightAnchor.constraint(equalToConstant: 50)
        return [topConstraint, leadingConstraint, trailingConstraint, heightConstraint]
    }
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func postImageViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.postImageView.topAnchor.constraint(equalTo: self.autorLabel.bottomAnchor, constant: 16)
        let leadingConstraint = self.postImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        let trailingConstraint = self.postImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        let multiplier: CGFloat
        if let image = self.postImageView.image {
            multiplier = image.size.height / image.size.width
        } else {
            multiplier = 1
        }
        let heightConstraint = self.postImageView.heightAnchor.constraint(equalTo: self.postImageView.widthAnchor, multiplier: multiplier)
        return [topConstraint, leadingConstraint, trailingConstraint, heightConstraint]
    }
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private func descriptionLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.descriptionLabel.topAnchor.constraint(equalTo: self.postImageView.bottomAnchor, constant: 16)
        let leadingConstraint = self.descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        let trailingConstraint = self.descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        let bottomConstraint = self.descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)
        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraint]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        self.contentView.addSubview(self.autorLabel)
        self.contentView.addSubview(self.postImageView)
        self.contentView.addSubview(self.descriptionLabel)
        
        NSLayoutConstraint.activate(
            self.scrollViewConstraints() +
            self.contentViewConstraints() +
            self.autorLabelConstraints() +
            self.postImageViewConstraints() +
            self.descriptionLabelConstraints()
        )
                
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func setup(with post: Post) {
        self.autorLabel.text = post.autor
        self.postImageView.image = UIImage(named: post.image)
        self.descriptionLabel.text = post.description
    }
    
    @objc private func handleTap(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
