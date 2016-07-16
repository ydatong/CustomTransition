//
//  LeftViewController.swift
//  CustomTransition
//
//  Created by 周永 on 16/7/16.
//  Copyright © 2016年 shuige. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController {

    @IBOutlet var closeBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func close(sender: AnyObject) {
        
        dismissViewControllerAnimated(true) { 
            
        }
    }

}
