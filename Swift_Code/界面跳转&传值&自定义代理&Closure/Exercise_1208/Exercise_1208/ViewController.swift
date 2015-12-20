//
//  ViewController.swift
//  Exercise_1208
//
//  Created by NCS on 08/12/15.
//  Copyright © 2015年 Balwant. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,SecondViewControllerDelegate,UITableViewDelegate{
    var secondVC : SecondViewController!

    @IBOutlet weak var infoLable: UILabel!
    @IBAction func next(sender: UIButton) {
        self.presentViewController(secondVC, animated: true) { () -> Void in
            print("go to next")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        secondVC = self.storyboard?.instantiateViewControllerWithIdentifier("SecondViewController") as! SecondViewController

        secondVC.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        secondVC.receivedString = "Good Evening !"
//        secondVC.delegate = self
        secondVC.myClosure = {
//            (sendValue: String) -> Void in
//            sendValue in
            self.infoLable.text = $0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
// MARK: - SecondViewControllerDelegate
    func updateInfo(str: String) {
        self.infoLable.text = str
    }
    
    

}

