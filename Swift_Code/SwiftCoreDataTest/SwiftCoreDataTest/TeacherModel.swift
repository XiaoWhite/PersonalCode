//
//  TeacherModel.swift
//  SwiftCoreDataTest
//
//  Created by NCS on 11/12/15.
//  Copyright © 2015年 Balwant. All rights reserved.
//

import UIKit

class TeacherModel: NSObject {
    
    var sex: String?
    var birthday: String?
    var staffNo: String?
    var name: String?
    
    init(staffNo: String, name: String, birthday: String, sex: String) {
        super.init()
        self.staffNo = staffNo
        self.name = name
        self.birthday = birthday
        self.sex = sex
    }

}
