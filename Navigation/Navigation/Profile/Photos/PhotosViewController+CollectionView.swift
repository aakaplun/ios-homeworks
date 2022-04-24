//
//  PhotosViewController+CollectionView.swift
//  Navigation
//
//  Created by Andrey Kaplun on 18/04/2022.
//  Copyright © 2022 Andrey Kaplun. All rights reserved.
//

import UIKit

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as? PhotosCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setup(with: images[indexPath.row])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        cell.setSingleTapGesture(tapGesture)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        let size = (self.collectionView.bounds.width - spacing * 2) / 3
        return CGSize(width: size, height: size)
    }
}
