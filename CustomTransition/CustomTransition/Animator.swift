//
//  Animator.swift
//  CustomTransition
//
//  Created by 周永 on 16/7/16.
//  Copyright © 2016年 shuige. All rights reserved.
//

import UIKit

enum PresentSide {
    case Left
    case Right
}

class Animator: NSObject ,UIViewControllerAnimatedTransitioning{
    
    var presenting: Bool = true
    var side: PresentSide!
    var animationCenter: CGPoint!
    
    var transitionContext: UIViewControllerContextTransitioning!
    var containView: UIView!
    var fromView: UIView!
    var toView: UIView!
    var fromVC: UIViewController!
    var toVC: UIViewController!
    var maskLayer: CAShapeLayer!
    
    let bounds: CGRect = UIScreen.mainScreen().bounds
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        self.transitionContext = transitionContext
        //获取所有跟转场有关系的对象
        containView = transitionContext.containerView()
        fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        //将即将要展现的view的frame设置为最终的frame
        toView.frame = transitionContext.finalFrameForViewController(toVC)
        //layer
        maskLayer = CAShapeLayer()
        
        //animation
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = transitionDuration(transitionContext)
        animation.delegate = self
        
        if presenting {
            
            /*containView作为转场动画中视图的容器
             我们如果要对哪个视图进行动画
             就需要把这个视图加入到containView中。
             当在present模态视图的时候
             我们需要处理的是即将要展示的View的layer，所以需要加入toView*/
            
            containView?.addSubview(toView)
            
            //设置动画的初始值和结束值，还有结束后的状态
            animation.fromValue = UIBezierPath(arcCenter: animationCenter,
                                               radius: 0,
                                               startAngle: 0,
                                               endAngle: CGFloat(M_PI*2),
                                               clockwise: true).CGPath
            animation.toValue = UIBezierPath(arcCenter: animationCenter,
                                             radius: radius(),
                                             startAngle: 0.0,
                                             endAngle: CGFloat(M_PI*2),
                                             clockwise: true).CGPath
            
            animation.fillMode = kCAFillModeForwards
            animation.removedOnCompletion = false
            toView.layer.mask = maskLayer
        }else{
            
            //dismiss与present类似，只是动画的初始值，和要操作的view有所不同
            
            containView.addSubview(toView)
            containView.addSubview(fromView)
            animation.fromValue = UIBezierPath(arcCenter: animationCenter,
                                               radius: radius(),
                                               startAngle: 0.0,
                                               endAngle: CGFloat(M_PI*2),
                                               clockwise: true).CGPath
            animation.toValue = UIBezierPath(arcCenter: animationCenter,
                                             radius: 0,
                                             startAngle: 0,
                                             endAngle: CGFloat(M_PI*2),
                                             clockwise: true).CGPath
            
            fromView.layer.mask = maskLayer
        }
        
        //将动画添加到mask
        maskLayer.addAnimation(animation, forKey: nil)
        
    }
    
    
    //动画结束
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if presenting {
            maskLayer.removeFromSuperlayer()
        }else{
            let clickedBtn = side == .Left ? (toVC as! ViewController).leftBtn : (toVC as! ViewController).rightBtn
            UIView.animateWithDuration(0.3, animations: {
                clickedBtn.transform = CGAffineTransformMakeScale(1, 1)
            })
        }
        
        //记住一定要在转场动画的结束的闭包，或者是代理方法中手动调用这个来结束！
        transitionContext.completeTransition(true)
    }
}


extension Animator {
    
    //计算圆形mask的半径
    
    func radius() -> CGFloat{
        
        let width = bounds.size.width
        let radius: CGFloat
        if side == .Left {
            radius = sqrt(CGFloat(animationCenter.x * animationCenter.x + animationCenter.y * animationCenter.y))
        }else{
            let x = animationCenter.x - width
            radius = sqrt(CGFloat(x * x + animationCenter.y * animationCenter.y))
        }
        return radius
    }
    
}














