//
//  ViewController.swift
//  SessionTest
//
//  Created by NCS on 09/12/15.
//  Copyright © 2015年 Balwant. All rights reserved.
//

import UIKit

let WeatherURLString = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22nome%2C%20ak%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"

let WebURL = "http://www.baidu.com"

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        self.webView.loadRequest(NSURLRequest(URL: NSURL(string: WebURL)!))
        print((Common.documentsPath() as String) + APP_NAME)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getData(sender: AnyObject) {
        
        print("start")
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true

        let url = NSURL(string: WebURL)!
        let request = NSURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request) {
            (data : NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            /*
            if let downloadData = data {
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(downloadData, options: NSJSONReadingOptions.MutableContainers)
                    print(json)
                }catch {
                    
                }
                
            } else {
                print("data is nil")
            }
*/
//            let httpResponse = response as! NSHTTPURLResponse
            
            
            if let httpResponse = response as? NSHTTPURLResponse {
                print(httpResponse.statusCode)
                self.webView.loadData(data!, MIMEType: "text/html", textEncodingName: "utf-8", baseURL: NSURL())
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            } else {
                print("load error")
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
            
            
        }
        dataTask.resume()

    }

}

