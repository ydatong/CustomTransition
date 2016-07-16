//
//  ViewController.swift
//  CustomTransition
//
//  Created by 周永 on 16/7/16.
//  Copyright © 2016年 shuige. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var clickedBtn: UIButton!
    var animator = Animator()
    
    @IBOutlet var leftBtn: UIButton!
    @IBOutlet var rightBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func showLeft(sender: AnyObject) {
        
        clickedBtn = sender as! UIButton
        animator.animationCenter = clickedBtn.center
        animator.side = PresentSide.Left
        
        UIView.animateWithDuration(0.5, animations: {
            self.clickedBtn.transform = CGAffineTransformMakeScale(0.1, 0.1)
        }) { (finished: Bool) in
            
            let leftVC = UIStoryboard(name: "Main",
                bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("leftVC")
            //设置代理
            leftVC.transitioningDelegate = self
            self.presentViewController(leftVC, animated: true) {
                
            }
        }
        
        
    }
    
    @IBAction func showMore(sender: AnyObject) {
        
        clickedBtn = sender as! UIButton
        animator.animationCenter = clickedBtn.center
        animator.side = PresentSide.Right
        
        UIView.animateWithDuration(0.5, animations: {
            self.clickedBtn.transform = CGAffineTransformMakeScale(0.1, 0.1)
        }) { (finished: Bool) in
            
            let rightVC = UIStoryboard(name: "Main",
                bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("rightVC")
            rightVC.transitioningDelegate = self
            self.presentViewController(rightVC, animated: true) {
                
            }
        }
        
    }
}


extension ViewController: UIViewControllerTransitioningDelegate {
    
    //提供转场动画控制器
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.presenting = true
        return animator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.presenting = false
        return animator
    }
}













