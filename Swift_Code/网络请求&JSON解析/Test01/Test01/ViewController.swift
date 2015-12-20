//
//  ViewController.swift
//  Test01
//
//  Created by NCS on 08/12/15.
//  Copyright © 2015年 Balwant. All rights reserved.
//

import UIKit

typealias SendValueClosure = (sendValue: String) -> Void

class ViewController: UIViewController {

    let urlStr = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22nome%2C%20ak%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
     @IBOutlet weak var weatherImageView: UIImageView!
    @IBAction func buttonClick(sender: AnyObject) {

        let url = NSURL(string: urlStr)!
        let request = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (response : NSURLResponse?, data : NSData?, error : NSError?) -> Void in
            if let downloadData = data {
                
                do{
                   let json = try NSJSONSerialization.JSONObjectWithData(downloadData, options: NSJSONReadingOptions.MutableContainers)
                    
                    let queryDict = json["query"] as! NSDictionary
                    let resultsDict = queryDict["results"] as! NSDictionary
                    let channelDict = resultsDict["channel"] as! NSDictionary
                    let imageDict = channelDict["image"] as! NSDictionary
                    
                    let imageUrl = imageDict["url"] as! NSString
                    print(imageUrl)
                    

//                    let image = UIImage(data: NSData(contentsOfURL: NSURL(string: "http://i5.download.fd.pchome.net/g1/M00/04/1E/ooYBAFHk1YWICnMlAApT0UKu9K8AAAvvgBfoPoAClPp525.jpg")!)!)
//                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                        self.weatherImageView.image = image
//                    })
                    
                    
                }catch {
                    print(error)
                }
                
                
               
                
            }
        }
        
    }
    
    

    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        let image = UIImage(named: "flag")!
        self.weatherImageView.image = image
        
//        self.weatherImageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.weatherImageView.layer.cornerRadius = self.weatherImageView.bounds.size.width * 0.5
//        self.weatherImageView.clipsToBounds = true
        self.weatherImageView.layer.masksToBounds = true
        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
//            () -> Void in
//            let image = UIImage(data: NSData(contentsOfURL: NSURL(string: "http://i5.download.fd.pchome.net/g1/M00/04/1E/ooYBAFHk1YWICnMlAApT0UKu9K8AAAvvgBfoPoAClPp525.jpg")!)!)
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                self.weatherImageView.image = image
//            })
//        }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

