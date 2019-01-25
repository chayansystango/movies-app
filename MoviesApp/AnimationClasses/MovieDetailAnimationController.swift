//
//  MovieDetailAnimationController.swift
//  MoviesApp
//
//  Created by Chayan on 25/01/19.
//  Copyright © 2019 Systango Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class MovieDetailAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    /// Variables
    var initialFrame = CGRect.zero
    
    // MARK: - UIViewControllerAnimatedTransitioning Delegate methods
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.75
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        toViewController.view.frame = initialFrame
        toViewController.view.clipsToBounds = true
        containerView.addSubview(toViewController.view)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromViewController.view.alpha = 0.5
            toViewController.view.frame = finalFrameForVC
        }) { (finished) in
            transitionContext.completeTransition(true)
            fromViewController.view.alpha = 1.0
        }
    }
}
