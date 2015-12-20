//
//  SecondViewController.swift
//  Exercise_1208
//
//  Created by NCS on 08/12/15.
//  Copyright © 2015年 Balwant. All rights reserved.
//

import UIKit

@objc protocol SecondViewControllerDelegate : NSObjectProtocol {
    optional func updateInfo (str : String) -> Void
}


typealias SendValueClosure = (sendValue : String) -> Void

class SecondViewController: UIViewController {
    
    var receivedString : String = ""
    var myClosure : SendValueClosure?
    
    weak internal var delegate: SecondViewControllerDelegate?
    @IBOutlet weak var infoLabel: UILabel!
    @IBAction func back(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.yellowColor()
        self.infoLabel.text = receivedString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func invokeDelegate(sender: UIButton) {

//        self.delegate?.updateInfo!("Go Home")
        if (myClosure != nil) {
            myClosure!(sendValue: "Good Morning")
        } else {
            print("not implement the closure")
        }
    }

    
    func blockFunction(str : String, block : (passValue : String) -> Void){
        block(passValue: str)
    }
}