//
//  GEBaseVC.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit
import CoreData

class GEBaseVC: BaseVC {
    
    let context = NSManagedObjectContext.init(concurrencyType: .MainQueueConcurrencyType)
   // var coreDataArr = [Place]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createCoreData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createCoreData(){
        let path = NSBundle.mainBundle().pathForResource("Info", ofType: "momd")
        let model = NSManagedObjectModel.init(contentsOfURL: NSURL.init(fileURLWithPath: path!))
        let coordinator = NSPersistentStoreCoordinator.init(managedObjectModel: model!)
        let sqlPath = NSHomeDirectory() + "/Documents/Info.sqlite"
        try! coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: NSURL.init(fileURLWithPath: sqlPath), options: nil)
        context.persistentStoreCoordinator = coordinator

    }


}
