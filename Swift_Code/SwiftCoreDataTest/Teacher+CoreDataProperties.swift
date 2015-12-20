//
//  Teacher+CoreDataProperties.swift
//  SwiftCoreDataTest
//
//  Created by NCS on 11/12/15.
//  Copyright © 2015年 Balwant. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Teacher {

    @NSManaged var sex: String?
    @NSManaged var birthday: String?
    @NSManaged var staffNo: String?
    @NSManaged var name: String?

}
