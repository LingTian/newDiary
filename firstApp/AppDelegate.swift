//
//  AppDelegate.swift
//  firstApp
//
//  Created by XIAO WU on 27/12/2017.
//  Copyright © 2017 XIAO WU. All rights reserved.
//

import UIKit
import CoreData
let appDelegate = UIApplication.shared.delegate as! AppDelegate

let managedContext = appDelegate.managedObjectContext!
let itemHeight:CGFloat=150.0
let itemWidth:CGFloat=60
let collectionViewWidth=itemWidth*3

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
   /* func PrintFonts() {
        
        let familyNames = UIFont.familyNames
        var index:Int = 0
        for familyName in familyNames
        {
            let fontNames = UIFont.fontNames(forFamilyName: familyName as String)
            let fontNames1 = UIFont.fontNames(forFamilyName: familyName as String)
            
            for fontName in fontNames
            {
                index += 1
                print("序号\(index):\(fontName)")
            }
        }
    }*/
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       //PrintFonts()
        return true
    }
    lazy var managedObjectmodel:NSManagedObjectModel = {
        
        let modelURL = Bundle.main.url(forResource: "Diary", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf:modelURL)!
    }()
    
    lazy var applicationDocumentsDirectory:URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // 通过 managedObjectModel 创建持久化管理
        var coordinator: NSPersistentStoreCoordinator? =
            NSPersistentStoreCoordinator(managedObjectModel:
                self.managedObjectmodel)
        
        let url = self.applicationDocumentsDirectory.appendingPathComponent("Diary.sqlite")
        // 设定数据库存储位置
        
        var error: NSError? = nil
        var failureReason = "载入程序存储的数据出错."
        
        do {
            try coordinator!.addPersistentStore(
                ofType: NSSQLiteStoreType, configurationName: nil,
                at: url, options: nil)
            // 创建NSSQLiteStoreType类型持久化存储
        } catch var error1 as NSError {
            error = error1
            coordinator = nil
            // 报告错误
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "无法初始化程序存储的数据" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("发现错误 \(String(describing: error)), \(error!.userInfo)")
            abort()
        } catch {
            fatalError()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "firstApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

