//
//  ViewController.swift
//  Internationalization
//
//  Copyright © 2015年 shoeisha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pushedButton(sender: UIButton) {
        
        let localizedTitle: String = NSLocalizedString("AlertTitle" , comment:"AlertTitle")
        
        let localizedMessage: String = NSLocalizedString("AlertMessage" , comment:"AlertMessage")
        
        let localizedCancel: String = NSLocalizedString("AlertCancel" , comment:"AlertCancel")
        
        let localizedOk: String = NSLocalizedString("AlertOk" , comment:"AlertOk")
        
        let alert:UIAlertController = UIAlertController(title:localizedTitle, message: localizedMessage, preferredStyle:UIAlertControllerStyle.Alert)
        
        let cancelAction:UIAlertAction = UIAlertAction(title: localizedCancel,
            style: UIAlertActionStyle.Cancel,
            handler:{
                (action:UIAlertAction!) -> Void in
        })
        
        let defaultAction:UIAlertAction = UIAlertAction(title: localizedOk,
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
        })
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
}

