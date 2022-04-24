//
//  PhotosViewController+TransitionDelegate.swift
//  Navigation
//
//  Created by Andrey Kaplun on 18/04/2022.
//  Copyright © 2022 Andrey Kaplun. All rights reserved.
//

import UIKit

extension PhotosViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        guard let photosViewController = source as? PhotosViewController,
            let transitionViewController = presented as? TransitionViewController,
            let selectedCellImageViewSnapshot = self.selectedCellImageViewSnapshot
            else { return nil }

        let animator = Animator(type: .present, firstViewController: photosViewController, secondViewController: transitionViewController, selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
        
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        guard let transitionViewController = dismissed as? TransitionViewController,
            let selectedCellImageViewSnapshot = self.selectedCellImageViewSnapshot
            else { return nil }

        let animator = Animator(type: .dismiss, firstViewController: self, secondViewController: transitionViewController, selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
        return animator
    }
    
    @objc internal func handleTap(sender: UITapGestureRecognizer) {
        if sender.state != .ended { return }
        guard let selectedCell = sender.view as? PhotosCollectionViewCell else { return }
        self.selectedCell = selectedCell
        self.selectedCellImageViewSnapshot = selectedCell.snapshotView(afterScreenUpdates: false)
        
        guard let image = selectedCell.imageView.image else { return }
        
        let transitionViewController = TransitionViewController()
        transitionViewController.transitioningDelegate = self
        transitionViewController.modalPresentationStyle = .overCurrentContext
        transitionViewController.setup(with: image)
        self.present(transitionViewController,  animated: true)
    }
}
