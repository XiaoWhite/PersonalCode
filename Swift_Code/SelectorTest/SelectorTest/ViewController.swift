//
//  ViewController.swift
//  SelectorTest
//
//  Created by NCS on 17/12/15.
//  Copyright © 2015年 Balwant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.performSelector("say:age:", withObject: "bwj", withObject: "23")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func say(name: String,age: String) {
        print(age)
        print("name = \(name) and age = \(age)")
    }

}

