//
//  NewsHelper.swift
//  ArcTest
//
//  Created by NCS on 15/12/15.
//  Copyright © 2015年 Balwant. All rights reserved.
//

import UIKit

class NewsHelper: NSObject {
    class var sharedInstance: NewsHelper{
        struct Static {
            static var instance: NewsHelper? = nil
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&Static.token) { () -> Void in
            Static.instance = NewsHelper()
        }
        return Static.instance!
    }
    
    func getNewsDataWith(urlStr: String,successBlock block:(array: [NewsModel]) -> Void){
        let url = NSURL(string: urlStr)
        let connectionManager = ConnectionManager.sharedInstance
        connectionManager.getDataWith(url!) { (responseData) -> Void in
            do{
                let dict = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.MutableContainers)
                
                let dictArray = dict["T1348649580692"] as! NSArray
                
                if dictArray.count == 0 {return}
                
                
                var newsArray = [NewsModel]()
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
                    
                    newsArray.append(newsModel)
                }
                
                block(array: newsArray)
                
            }catch {
                print("serialize fail")
            }
        }
    }
    
}
