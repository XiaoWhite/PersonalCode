//
//  ViewController.swift
//  AlertViewTest
//
//  Created by NCS on 15/12/15.
//  Copyright © 2015年 Balwant. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIAlertViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlertView(sender: AnyObject) {
        
        let alert = UIAlertView(title: "Test", message: "Close?", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "OK","hello","world")
        alert.show()
        
    }
    
    
    @IBAction func showAlertController(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Test", message: "Close?", preferredStyle: UIAlertControllerStyle.Alert)
        
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
            (okAction) -> Void in
            print("okAction")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        let thirdAction = UIAlertAction(title: "Third", style: UIAlertActionStyle.Default) { (thirdAction) -> Void in
            print("thirdAction")
        }
        
        alertController.addAction(thirdAction)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func showTextFieldAlert(sender: AnyObject) {
        
        let alert = UIAlertController(title: "Test", message: "Close?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler { (userNameField: UITextField!) -> Void in
            userNameField.placeholder = "User Name"
        }
        alert.addTextFieldWithConfigurationHandler { (passwordField: UITextField) -> Void in
            passwordField.placeholder = "password"
            passwordField.secureTextEntry = true
        }
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
            (okAction) -> Void in
            print("okAction")
            
            let userName = alert.textFields![0].text
            let password = alert.textFields![1].text
            
            if userName != nil && password != nil {
                self.okAction(userName!, password: password!)
            }
            
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func okAction(userName: String, password : String){
        print(userName + " " + password)
    }
    
    
    @IBAction func showActionSheet(sender: AnyObject) {
        
        let actionSheet = UIAlertController(title: "Sheet", message: "Which One ?", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
            (okAction) -> Void in
            print("okAction")
        })
        let deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Destructive, handler: {
            (okAction) -> Void in
            print("Delete Action")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        
        
        actionSheet.addAction(deleteAction)
        actionSheet.addAction(okAction)
        actionSheet.addAction(cancelAction)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func showPopover(sender: AnyObject) {
        
        
        
        let actionSheet = UIAlertController(title: "Sheet", message: "Which One ?", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
            (okAction) -> Void in
            print("okAction")
        })
        let deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Destructive, handler: {
            (okAction) -> Void in
            print("Delete Action")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {
            (cancelAction) -> Void in
            print("cancel")
        })
        
        
        
        actionSheet.addAction(deleteAction)
        actionSheet.addAction(okAction)
        actionSheet.addAction(cancelAction)
        
        
        let popover = actionSheet.popoverPresentationController
        if popover != nil{
            popover?.sourceView = sender as! UIButton
            popover?.sourceRect = (sender as! UIButton).bounds
            popover?.permittedArrowDirections = UIPopoverArrowDirection.Any
        }
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
        
        
    }

    
    @IBAction func showPopPresentation(sender: AnyObject) {
        
        let popover = UIPopoverPresentationController.init
        
    }
    // MARK: - AlertViewDelegate
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        print("buttonIndex = \(buttonIndex)")
    }

}

