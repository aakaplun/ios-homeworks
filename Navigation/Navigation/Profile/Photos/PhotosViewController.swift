//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Andrey Kaplun on 14/03/2022.
//  Copyright © 2022 Andrey Kaplun. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        return layout
    }()

    internal lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    internal lazy var images: [UIImage] = {
        var images = [UIImage]()
        for i in 1...20 {
            let name = "Photo" + String(i)
            if let image = UIImage(named: name) {
                images.append(image)
            }
        }
        return images
    }()
    
    internal var selectedCell: PhotosCollectionViewCell?
    internal var selectedCellImageViewSnapshot: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Photo Gallery"
        navigationItem.largeTitleDisplayMode = .never
        
        self.view.addSubview(collectionView)
        
        let margins = self.view.safeAreaLayoutGuide
        let topConstraint = self.collectionView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 8)
        let bottomConstraint = self.collectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -8)
        let leadingConstraint = self.collectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 8)
        let trailingConstraint = self.collectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -8)
        
        NSLayoutConstraint.activate([
            topConstraint, bottomConstraint, leadingConstraint, trailingConstraint
        ])
    }
}
