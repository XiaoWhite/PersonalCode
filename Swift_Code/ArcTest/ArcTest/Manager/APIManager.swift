//
//  APIManager.swift
//  ArcTest
//
//  Created by NCS on 15/12/15.
//  Copyright © 2015年 Balwant. All rights reserved.
//

import UIKit

class APIManager: NSObject {
    class var sharedInstance: APIManager {
        struct Static {
            static var instance: APIManager? = nil
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&Static.token) { () -> Void in
            Static.instance = APIManager()
        }
        return Static.instance!
    }
    

}
