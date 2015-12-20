//
//  ViewController.swift
//  ArcTest
//
//  Created by NCS on 15/12/15.
//  Copyright © 2015年 Balwant. All rights reserved.
//

import UIKit

let kWangyiHeadNewsAPI = "http://c.m.163.com/nc/article/headline/T1348649580692/0-20.html"


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let newsHelper = NewsHelper.sharedInstance
        newsHelper.getNewsDataWith(kWangyiHeadNewsAPI) { (array) -> Void in
//            for news in array{
//                print(news.title!)
//            }
            for (index,news) in array.enumerate(){
                print("index = \(index), news' title = \(news.title)")
            }
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

