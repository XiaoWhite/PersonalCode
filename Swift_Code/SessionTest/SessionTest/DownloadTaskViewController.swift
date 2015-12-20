//
//  DownloadTaskViewController.swift
//  SessionTest
//
//  Created by NCS on 14/12/15.
//  Copyright © 2015年 Balwant. All rights reserved.
//

import UIKit


let kImageURL = "http://phs.asia/wp-content/uploads/2015/06/25-120619141504c3.jpg"

class DownloadTaskViewController: UIViewController,NSURLSessionDelegate,NSURLSessionDownloadDelegate,NSURLSessionDataDelegate {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var imageView: UIImageView!
    
    var currentSession : NSURLSession?
    var downloadTask : NSURLSessionDownloadTask?
    
    
    var partialData : NSData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        progressView.progress = 0.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createCurrentSession(){
        currentSession = NSURLSession.init(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: NSOperationQueue.mainQueue())
    }

    @IBAction func startTask(sender: AnyObject) {
        
        if currentSession == nil {
            self.createCurrentSession()
        }
        
        if partialData == nil {
//            downloadTask = currentSession?.downloadTaskWithRequest()
            downloadTask = currentSession?.downloadTaskWithRequest(NSURLRequest(URL: NSURL(string: kImageURL)!))
//            downloadTask = currentSession?.downloadTaskWithRequest(NSURLRequest(URL: NSURL(string: kImageURL)!), completionHandler: { (url: NSURL?, response: NSURLResponse?, error: NSError?) -> Void in
//                print(url)
//            })
        } else {
            downloadTask = currentSession?.downloadTaskWithResumeData(partialData!)
        }
        
        downloadTask?.resume()
    }
    
    @IBAction func pauseTastk(sender: AnyObject) {
        
        downloadTask?.cancelByProducingResumeData({ (data: NSData?) -> Void in
            self.partialData = data
        })
        
    }
    
    @IBAction func cancelTask(sender: AnyObject) {
        
        downloadTask?.cancel()
        downloadTask = nil
    }
    
    // MARK: - NSURLSessionDataDelegate
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        print("didReceiveData")
    }

    
    
    // MARK: - NSURLSessionDownloadDelegate
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        print("didFinishDownloadingToURL")
        
        let cache = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last
        
        let filePath = cache?.stringByAppendingString((downloadTask.response?.suggestedFilename)!)
        print(filePath)
        
        
        let fileManager = NSFileManager.defaultManager()
        
        if fileManager.fileExistsAtPath(filePath!){
            do{
                try fileManager.removeItemAtPath(filePath!)
            }catch{
                print(error)
            }
        }
        
        
        do{
            try fileManager.moveItemAtPath(location.path!, toPath: filePath!)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.imageView.image = UIImage(contentsOfFile: filePath!)
            })
        }catch{
            print(error)
        }
        
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        print("didResumeAtOffset = \(fileOffset)" + " expectedTotalBytes = \(expectedTotalBytes)")
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {

        
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.progressView.progress = progress
        }
        
    }
   
}
