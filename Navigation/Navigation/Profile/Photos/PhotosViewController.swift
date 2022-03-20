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

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var images: [UIImage] = {
        var images = [UIImage]()
        for i in 1...20 {
            let name = "Photo" + String(i)
            if let image = UIImage(named: name) {
                images.append(image)
            }
        }
        return images
    }()
    
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

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as? PhotosCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setup(with: images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        let size = (self.collectionView.bounds.width - spacing * 2) / 3
        return CGSize(width: size, height: size)
    }
}
