//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Andrey Kaplun on 06/03/2022.
//  Copyright © 2022 Andrey Kaplun. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    private lazy var autorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func autorLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.autorLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16)
        let leadingConstraint = self.autorLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        let trailingConstraint = self.autorLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        return [topConstraint, leadingConstraint, trailingConstraint]
    }
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func postImageViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.postImageView.topAnchor.constraint(equalTo: self.autorLabel.bottomAnchor, constant: 16)
        let leadingConstraint = self.postImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        let trailingConstraint = self.postImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        let heightConstraint = self.postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor)
        return [topConstraint, leadingConstraint, trailingConstraint, heightConstraint]
    }
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private func descriptionLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.descriptionLabel.topAnchor.constraint(equalTo: self.postImageView.bottomAnchor, constant: 16)
        let leadingConstraint = self.descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        let trailingConstraint = self.descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        return [topConstraint, leadingConstraint, trailingConstraint]
    }

    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func likesLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.likesLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16)
        let leadingConstraint = self.likesLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        let bottomConstraint = self.likesLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)
        return [topConstraint, leadingConstraint, bottomConstraint]
    }
    
    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private func viewsLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.viewsLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16)
        let trailingConstraint = self.viewsLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        return [topConstraint, trailingConstraint]
    }

    private func setupView() {
        self.contentView.addSubview(self.autorLabel)
        self.contentView.addSubview(self.postImageView)
        self.contentView.addSubview(self.descriptionLabel)
        self.contentView.addSubview(self.likesLabel)
        self.contentView.addSubview(self.viewsLabel)
                
        let autorLabelConstraints = self.autorLabelConstraints()
        let postImageViewConstraints = self.postImageViewConstraints()
        let descriptionLabelConstraints = self.descriptionLabelConstraints()
        let likesLabelConstraints = self.likesLabelConstraints()
        let viewsLabelConstraints = self.viewsLabelConstraints()
        
        NSLayoutConstraint.activate(
            autorLabelConstraints
            + postImageViewConstraints
            + descriptionLabelConstraints
            + likesLabelConstraints
            + viewsLabelConstraints
        )
    }
    
    func setGestures(_ likeTapGesture: UITapGestureRecognizer, _ imageTapGesture: UITapGestureRecognizer, for indexPath: IndexPath) {
        self.likesLabel.tag = indexPath.row
        self.likesLabel.isUserInteractionEnabled = true
        self.likesLabel.addGestureRecognizer(likeTapGesture)
        
        self.postImageView.tag = indexPath.row
        self.postImageView.isUserInteractionEnabled = true
        self.postImageView.addGestureRecognizer(imageTapGesture)
    }
    
    func setup(with post: Post) {
        self.autorLabel.text = post.autor
        self.postImageView.image = UIImage(named: post.image)
        self.descriptionLabel.text = post.description
        self.setLikes(to: post.likes)
        self.viewsLabel.text = "Views: " + String(post.views)
    }
    
    func setLikes(to number: Int) {
        self.likesLabel.text = "Likes: \(number)"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.autorLabel.text = nil
        self.postImageView.image = nil
        self.descriptionLabel.text = nil
        self.likesLabel.text = nil
        self.viewsLabel.text = nil
    }

}
