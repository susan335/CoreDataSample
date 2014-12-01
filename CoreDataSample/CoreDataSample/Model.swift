//
//  CoreDataSample.swift
//  CoreDataSample
//
//  Created by Susan on 2014/12/01.
//  Copyright (c) 2014年 watanave. All rights reserved.
//

import Foundation
import CoreData

class Model: NSManagedObject {

    @NSManaged var someDataA: String
    @NSManaged var someDataB: NSNumber

}
