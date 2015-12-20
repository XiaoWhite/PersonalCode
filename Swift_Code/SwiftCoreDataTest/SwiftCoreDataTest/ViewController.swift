//
//  ViewController.swift
//  SwiftCoreDataTest
//
//  Created by NCS on 11/12/15.
//  Copyright © 2015年 Balwant. All rights reserved.
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


    @IBAction func insertTeacher(sender: AnyObject) {
        let manager = CoreDataManager()
        let model = TeacherModel(staffNo: "12345", name: "Hello", birthday: "1992-01-01", sex: "Male")
        let returnValue = manager.insertTeacher(model)
        if returnValue == 0{
            print("insert error")
        } else {
            print("Insert Successfully")
        }
    }
    
    @IBAction func queryTeacher(sender: AnyObject) {
        
        let manager = CoreDataManager()
        let array = manager.searchTeacherByStaffNo("12345")
        
        for item in array{
            print(item.name! + item.birthday!)
        }
    }
    
    @IBAction func deleteTeacher(sender: AnyObject) {
        
        let manager = CoreDataManager()
        let result = manager.deleteTeacherByStaffNo("12345")
        
        if result == 0 {
            print("delete fail")
        }
    }
}

