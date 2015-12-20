//
//  MainTableViewController.swift
//  Exercise_1209
//
//  Created by NCS on 09/12/15.
//  Copyright © 2015年 Balwant. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController,MBProgressHUDDelegate {

    var dataList : [String] = []
    var HUD : MBProgressHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        dataList += ["one","two","three","four","five","six","seven"]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataList.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...

        cell.textLabel?.text = dataList[indexPath.row]
        return cell
    }


   // MARK: - TableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch dataList[indexPath.row]{
            case "one":
                print("one")
                HUD = MBProgressHUD(view: self.view)
            HUD?.delegate = self
            HUD?.backgroundColor = UIColor(colorLiteralRed: 26.0/255, green: 206.0/255, blue: 252.0/255, alpha: 0.7)
            self.view.addSubview(HUD!)
            HUD?.showAnimated(true, whileExecutingBlock: { () -> Void in
                    sleep(3)
                }, completionBlock: { () -> Void in
                    print("Simple HUD Finished")
            })
            
            case "two":
            print("two")
            HUD = MBProgressHUD(view: self.view)
            HUD?.delegate = self
            HUD?.mode = MBProgressHUDMode.AnnularDeterminate
            HUD?.labelText = "Loading..."
            self.view.addSubview(HUD!)
            HUD?.showAnimated(true, whileExecutingBlock: { () -> Void in
                var progress : Float = 0.0
                while progress < 1.0 {
                    progress += 0.01
                    self.HUD?.progress = progress
                    usleep(50000)
                }
                }, completionBlock: nil)
            
            case "three":
            print("three")
            HUD = MBProgressHUD(view: self.view)
            self.view.addSubview(HUD!)
            HUD?.delegate = self
            HUD?.mode = MBProgressHUDMode.AnnularDeterminate
            HUD?.labelText = "Loading..."
            HUD?.showAnimated(true, whileExecutingBlock: { () -> Void in
                var progress : Float = 0.0
                while progress < 1.0 {
                    progress += 0.01
                    self.HUD?.progress = progress
                    usleep(50000)
                }
                
                // complete
                self.HUD?.mode = MBProgressHUDMode.CustomView
                var imageView = UIImageView()
                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                    imageView = UIImageView(image: UIImage(named: "37x-Checkmark.png"))
                })
                self.HUD?.customView = imageView
                self.HUD?.labelText = "Completed"
                sleep(2)
            })
            
        default : print("Don't exit this case")
        }
    }

    // MARK: - MBProgressHUDDelegate
    func hudWasHidden(hud: MBProgressHUD!) {
        HUD?.removeFromSuperview()
        HUD = nil
    }
}
