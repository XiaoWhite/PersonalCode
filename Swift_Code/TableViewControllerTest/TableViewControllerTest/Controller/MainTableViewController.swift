//
//  MainTableViewController.swift
//  TableViewControllerTest
//
//  Created by NCS on 10/12/15.
//  Copyright © 2015年 Balwant. All rights reserved.
//

import UIKit

let kWangyiHeadNewsAPI = "http://c.m.163.com/nc/article/headline/T1348649580692/0-20.html"



class MainTableViewController: UITableViewController,NSURLSessionDelegate,NSURLSessionDataDelegate {

    var newsDataList = [NewsModel]()
//    var receivedData : NSMutableData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // register NewsCell
        
        
        self.title = "News"
        
        self.tableView.registerNib(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        
        self.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        let url = NSURL(string: kWangyiHeadNewsAPI)
        let request = NSURLRequest(URL: url!)
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        
        let session = NSURLSession.init(configuration: configuration, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        
        let task = session.dataTaskWithRequest(request) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if let receivedData = data {
                do{
                    let dict = try NSJSONSerialization.JSONObjectWithData(receivedData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    let dictArray = dict["T1348649580692"] as! NSArray
                    
                    if dictArray.count == 0 {return}
                    
                    // start serialize
                    for newsDict in dictArray {
                        
                       
                        let newsModel = NewsModel()
                        newsModel.title = newsDict["title"] as? String
                        newsModel.digest = newsDict["digest"] as? String
                        newsModel.subtitle = newsDict["subtitle"] as? String
                        newsModel.ptime = newsDict["ptime"] as? String
                        newsModel.hasIcon = newsDict["hasIcon"] as? Bool
                        newsModel.priority = newsDict["priority"] as? Int
                        newsModel.url = newsDict["url"] as? String
                        newsModel.imgsrc = newsDict["imgsrc"] as? String
                        
                        self.newsDataList.append(newsModel)
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tableView.reloadData()
                    })
                    
                }catch{
                    print("serialze error")
                }
            } else {
                print("request error:\(error)")
            }
        }
        task.resume()
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsDataList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NewsCell", forIndexPath: indexPath) as! NewsCell

        cell.iconImage.image = nil
        
        // Configure the cell...
        let news = newsDataList[indexPath.row]
        cell.newsModel = news
        
//        cell.iconImage.image = UIImage(named: "hai1")
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            () -> Void in
            let imageData = NSData(contentsOfURL: NSURL(string: news.imgsrc!)!)
            let image = UIImage(data: imageData!)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                let newsCell = tableView.cellForRowAtIndexPath(indexPath)
//                if let instanceCell = newsCell {
//                    instanceCell.imageView?.image = image
//                    tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
                
//                }
                cell.iconImage.image = image
                
            })
        }

        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }

    // MARK: - NSURLSessionDelegate
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveResponse response: NSURLResponse, completionHandler: (NSURLSessionResponseDisposition) -> Void) {
        print(response)
    }
    
//    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
//        receivedData?.appendData(data)
//        print(data.length)
//    }
//    func URLSessionDidFinishEventsForBackgroundURLSession(session: NSURLSession) {
//        print("URLSessionDidFinishEventsForBackgroundURLSession")
//        print(receivedData?.length)
//    }
    

}
