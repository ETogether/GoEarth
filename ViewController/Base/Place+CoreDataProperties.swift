//
//  Place+CoreDataProperties.swift
//  GoEarth
//
//  Created by qianfeng on 16/10/6.
//  Copyright © 2016年 u. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Place {

    @NSManaged var score: String?
    @NSManaged var reviews: String?
    @NSManaged var recordId: String?
    @NSManaged var nameCn: String?
    @NSManaged var name: String?
    @NSManaged var module: String?
    @NSManaged var countryName: String?
    @NSManaged var imageUrl: String?
    @NSManaged var countryId: String?
    @NSManaged var cityName: String?

}
