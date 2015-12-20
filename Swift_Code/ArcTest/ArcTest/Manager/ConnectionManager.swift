//
//  ConnectionManager.swift
//  ArcTest
//
//  Created by NCS on 15/12/15.
//  Copyright © 2015年 Balwant. All rights reserved.
//

import UIKit

class ConnectionManager: NSObject {
    class var sharedInstance: ConnectionManager{
        get{
            struct Static {
                static var instance: ConnectionManager? = nil
                static var token: dispatch_once_t = 0
            }
            
            dispatch_once(&Static.token) { () -> Void in
                Static.instance = ConnectionManager()
            }
            return Static.instance!
        }
    }
    
    
    func getDataWith(url: NSURL,successBlock block:(responseData: NSData) -> Void){
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let dataTask = session.dataTaskWithRequest(NSURLRequest(URL: url)) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if let responseData = data {
                block(responseData: responseData)
            } else {
                print("request fail")
            }
        }
        dataTask.resume()
    }
    
    
}
