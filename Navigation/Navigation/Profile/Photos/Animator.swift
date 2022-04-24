//
//  Animator.swift
//  Navigation
//
//  Created by Andrey Kaplun on 18/04/2022.
//  Copyright © 2022 Andrey Kaplun. All rights reserved.
//

import UIKit

final class Animator: NSObject, UIViewControllerAnimatedTransitioning {

    enum PresentationType {
        case present
        case dismiss
        
        var isPresenting: Bool {
            return self == .present
        }
    }
    
    static let duration: TimeInterval = 0.5
    
    private let type: PresentationType
    private let firstViewController: PhotosViewController
    private let secondViewController: TransitionViewController
    private var selectedCellImageViewSnapshot: UIView
    private let cellImageViewRect: CGRect
    
    init?(type: PresentationType, firstViewController: PhotosViewController, secondViewController: TransitionViewController, selectedCellImageViewSnapshot: UIView) {
        self.type = type
        self.firstViewController = firstViewController
        self.secondViewController = secondViewController
        self.selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
        
        guard let window = firstViewController.view.window ?? secondViewController.view.window,
            let selectedCell = firstViewController.selectedCell
            else { return nil }
        
        self.cellImageViewRect = selectedCell.imageView.convert(selectedCell.imageView.bounds, to: window)
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        guard let toView = secondViewController.view
            else {
                transitionContext.completeTransition(false)
                return
        }
        
        containerView.addSubview(toView)
        
        guard let selectedCell = firstViewController.selectedCell,
            let window = firstViewController.view.window ?? secondViewController.view.window,
            let cellImageSnapshot = selectedCell.imageView.snapshotView(afterScreenUpdates: true),
            let controllerImageSnapshot = secondViewController.imageView.snapshotView(afterScreenUpdates: true)
            else {
                transitionContext.completeTransition(true)
                return
        }
        
        let isPresenting = type.isPresenting
        
        let backgroundView: UIView
        let fadeView = UIView(frame: containerView.bounds)
        fadeView.backgroundColor = secondViewController.view.backgroundColor
        
        if isPresenting {
            selectedCellImageViewSnapshot = cellImageSnapshot
            backgroundView = UIView(frame: containerView.bounds)
            backgroundView.addSubview(fadeView)
            fadeView.alpha = 0
        } else {
            backgroundView = firstViewController.view.snapshotView(afterScreenUpdates: true) ?? fadeView
            backgroundView.addSubview(fadeView)
        }
        
        toView.alpha = 0
        
        [backgroundView, selectedCellImageViewSnapshot, controllerImageSnapshot].forEach { containerView.addSubview($0) }
        
        let controllerImageViewRect = secondViewController.imageView.convert(secondViewController.imageView.bounds, to: window)
        
        [selectedCellImageViewSnapshot, controllerImageSnapshot].forEach {
            $0.frame = isPresenting ? cellImageViewRect : controllerImageViewRect
        }
        
        controllerImageSnapshot.alpha = isPresenting ? 0 : 1
        selectedCellImageViewSnapshot.alpha = isPresenting ? 1 : 0

        if isPresenting, let selectedCell = self.firstViewController.selectedCell {
            selectedCell.alpha = 0
        }

        UIView.animateKeyframes(withDuration: Self.duration, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.selectedCellImageViewSnapshot.frame = isPresenting ? controllerImageViewRect : self.cellImageViewRect
                controllerImageSnapshot.frame = isPresenting ? controllerImageViewRect : self.cellImageViewRect
                fadeView.alpha = isPresenting ? 1 : 0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.selectedCellImageViewSnapshot.alpha = isPresenting ? 0 : 1
                controllerImageSnapshot.alpha = isPresenting ? 1 : 0
                self.firstViewController.view.alpha = isPresenting ? 0.5 : 1
            }
        }, completion: { _ in
            self.selectedCellImageViewSnapshot.removeFromSuperview()
            controllerImageSnapshot.removeFromSuperview()
            backgroundView.removeFromSuperview()
            toView.alpha = 1
            transitionContext.completeTransition(true)
            if !isPresenting, let selectedCell = self.firstViewController.selectedCell {
                selectedCell.alpha = 1
            }
        })
    }
}
