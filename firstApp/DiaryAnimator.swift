//
//  DiaryAnimator.swift
//  firstApp
//
//  Created by XIAO WU on 31/12/2017.
//  Copyright © 2017 XIAO WU. All rights reserved.
//

import UIKit

class DiaryAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var operation:UINavigationControllerOperation!
    
    // 转场时长
    
    func transitionDuration(using transitionContext:
        UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext:
        UIViewControllerContextTransitioning)
    {
        
        // 获取转场舞台
        let containerView = transitionContext.containerView
        
        let fromVC = transitionContext.viewController(
            forKey: UITransitionContextViewControllerKey.from)
        
        // 获取从哪个场景开始转
        let fromView = fromVC!.view
        
        let toVC = transitionContext.viewController(
            forKey: UITransitionContextViewControllerKey.to)
        
        // 获取要转去哪个场景
        let toView = toVC!.view
        
        // 设置新场景透明度
        toView?.alpha = 0.0
        
        // UINavigationControllerOperation.Pop用来判断是转入还是转出
        if operation ==  UINavigationControllerOperation.pop {
            // 如果是返回旧场景，那么设置要转入的场景初始缩放为原始大小
            toView?.transform = CGAffineTransform(scaleX: 1.0,y: 1.0)
        }else{
            // 如果是转到新场景，设置新场景初始缩放为0.3
            toView?.transform = CGAffineTransform(scaleX: 0.3,y: 0.3);
        }
        
        // 在舞台上插入场景
        containerView.insertSubview(toView!, aboveSubview: fromView!)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            options: UIViewAnimationOptions.curveEaseInOut,
            animations:
            {
                if self.operation ==  UINavigationControllerOperation.pop {
                    // 放大要转出的场景
                    fromView?.transform = CGAffineTransform(scaleX: 3.3,y: 3.3)
                } else {
                    // 设置新场景为原始大小
                    toView?.transform = CGAffineTransform(scaleX: 1.0,y: 1.0)
                }
                
                toView?.alpha = 1.0
                
        }, completion: { finished in
            
            // 通知NavigationController已经完成转场
            transitionContext.completeTransition(true)
            
        })
        
        
    }
    
}
