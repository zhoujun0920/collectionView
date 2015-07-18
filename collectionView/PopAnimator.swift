//
//  PopAnimator.swift
//  collectionView
//
//  Created by Jun Zhou on 7/16/15.
//  Copyright (c) 2015 Jun Zhou. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration    = 0.5
    var presenting  = true
    var originFrame = CGRect.zeroRect
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning)-> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let baseView = presenting ? toView : transitionContext.viewForKey(UITransitionContextFromViewKey)!
        
        let initialFrame = presenting ? originFrame : baseView.frame
        let finalFrame = presenting ? baseView.frame : originFrame
        
        let xScaleFactor = presenting ?
            initialFrame.width / finalFrame.width :
            finalFrame.width / initialFrame.width
        
        let yScaleFactor = presenting ?
            initialFrame.height / finalFrame.height :
            finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor)
        
        if presenting {
            baseView.transform = scaleTransform
            baseView.center = CGPoint(
                x: CGRectGetMidX(initialFrame),
                y: CGRectGetMidY(initialFrame))
            baseView.clipsToBounds = true
        }
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(baseView)
        
        UIView.animateWithDuration(duration, delay:0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: nil,
            animations: {
                baseView.transform = self.presenting ?
                    CGAffineTransformIdentity : scaleTransform
                
                baseView.center = CGPoint(x: CGRectGetMidX(finalFrame),
                    y: CGRectGetMidY(finalFrame))
                
            }, completion:{_ in
                transitionContext.completeTransition(true)
        })
        
    }
    
}
