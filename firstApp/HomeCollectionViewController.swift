//
//  HomeCollectionViewController.swift
//  firstApp
//
//  Created by XIAO WU on 28/12/2017.
//  Copyright © 2017 XIAO WU. All rights reserved.
//

import UIKit
import CoreData
private let reuseIdentifier = "Cell"

class HomeCollectionViewController: UICollectionViewController {
    var diarys = [Diary]()
    var fetchedResultsController : NSFetchedResultsController<Diary>!
    var yearsCount :  Int = 1
    var sectionsCount : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
       
        let yearLayout = DiaryLayout()
        
        yearLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        self.collectionView?.setCollectionViewLayout(yearLayout, animated: false)
        
        self.navigationController!.delegate = self
        // Register cell classes
       // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        do {
            // 新建查询
            let fetchRequest = NSFetchRequest<Diary>(entityName:"Diary")
            
            // 排序方式
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "created_at", ascending: true)]
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: managedContext, sectionNameKeyPath: "year",
                                                                  cacheName: nil)
            
            // 尝试查询
            try self.fetchedResultsController.performFetch()
            
            if (fetchedResultsController.fetchedObjects!.count == 0){
                print("没有存储结果")
            }else{
                
                if let sectionsCount = fetchedResultsController.sections?.count {
                    
                    yearsCount = sectionsCount
                    diarys = fetchedResultsController.fetchedObjects!
                    
                }else {
                    sectionsCount = 0
                    yearsCount = 1
                }
            }
            
        } catch let error as NSError {
            NSLog("发现错误 \(error.localizedDescription)")
        }
    

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return yearsCount
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
  
        // #warning Incomplete implementation, return the number of items
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
    
        let identifier="DiaryYearCollectionViewController"
        let dvc = self.storyboard?.instantiateViewController(withIdentifier: identifier)as! DiaryYearCollectionViewController
        let components = Calendar.current.component(Calendar.Component.year, from: Date())
        var year = components
        if sectionsCount > 0 {
            let sectionInfo = fetchedResultsController.sections![indexPath.section]
            print ("分组信息 \(sectionInfo.name)")
            year = Int(sectionInfo.name)!
            
        }
        dvc.year=year
        self.navigationController!.pushViewController(dvc, animated: true)
        
      //  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! HomeYearCollectionViewCell
        
        //get month
        //
        //
        /*
       
        //cell.textInt = year
        cell.labelText = "\(numberToChinese(cell.textInt))年"
        */
      
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "HomeYearCollectionViewCell"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! HomeYearCollectionViewCell
        
        let components = Calendar.current.component(Calendar.Component.year, from: Date())
        var year = components
        
        if sectionsCount > 0 {
            let sectionInfo = fetchedResultsController.sections![indexPath.section]
            print ("分组信息 \(sectionInfo.name)")
            year = Int(sectionInfo.name)!
            
        }
        
        cell.textInt = year
        cell.labelText = "\(numberToChinese(cell.textInt)) 年"
//        "二零一五 年"
        
        return cell
        
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension HomeCollectionViewController:UINavigationControllerDelegate{
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC:UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = DiaryAnimator()
        animator.operation = operation
        return animator
    }
}
