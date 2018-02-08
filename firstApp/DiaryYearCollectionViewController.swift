//
//  DiaryYearCollectionViewController.swift
//  firstApp
//
//  Created by XIAO WU on 29/12/2017.
//  Copyright © 2017 XIAO WU. All rights reserved.
//

import UIKit
import CoreData
private let reuseIdentifier = "Cell"

class DiaryYearCollectionViewController: UICollectionViewController {
    
    var year : Int!
    var diarys = [Diary]()
    var fetchedResultsController: NSFetchedResultsController<Diary>!
    var monthCount: Int = 1
    var sectionsCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout=DiaryLayout()
        //let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(DiaryYearCollectionViewController.back))
      /*  let moreTap = UITapGestureRecognizer.init(target:self, action: #selector(DiaryYearCollectionViewController.back))
        moreTap.numberOfTapsRequired = 2//触发响应的点击次数
        // 这句可有可无, 因为默认方向就是Right
        //rightSwipe.direction = .Right
        
        // 添加手势到需要响应的视图
        self.view.addGestureRecognizer(moreTap)*/
        addGester()
        layout.scrollDirection=UICollectionViewScrollDirection.horizontal
        self.collectionView?.setCollectionViewLayout(layout, animated:false)
        
        do {
            // 新建查询
            let fetchRequest = NSFetchRequest<Diary>(entityName:"Diary")
            
            //filter
            fetchRequest.predicate = NSPredicate(format: "year = \(year!)")
            
            // 排序方式
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "created_at", ascending: true)]
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: managedContext, sectionNameKeyPath: "month",
                                                                  cacheName: nil)
            
            // 尝试查询
            try self.fetchedResultsController.performFetch()
            
            if (fetchedResultsController.fetchedObjects!.count == 0){
                print("没有存储结果")
            }else{
                
                if let sectionsCount = fetchedResultsController.sections?.count {
                    
                    monthCount = sectionsCount
                    diarys = fetchedResultsController.fetchedObjects!
                    
                }else {
                    sectionsCount = 0
                    monthCount = 1
                }
            }
            
        } catch let error as NSError {
            NSLog("发现错误 \(error.localizedDescription)")
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

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
        return monthCount
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier="DiaryCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)as! DiaryCell

        let components = Calendar.current.component(Calendar.Component.month, from: Date())
        var month = components
        
        if sectionsCount > 0 {
            let sectionInfo = fetchedResultsController.sections![indexPath.section]
            print("分组信息\(sectionInfo.name)")
            month = Int(sectionInfo.name)!
            
            
        }
        
        cell.textInt=month
        cell.labelText="\(numberToChinese(cell.textInt)) 月"
        
        // Configure the cell
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        let components = Calendar.current.component(Calendar.Component.month, from: Date())
        let identifier="DiaryMonthCollectionViewController"
        let dvc = self.storyboard?.instantiateViewController(withIdentifier: identifier)as! DiaryMonthCollectionViewController
        var month = components
        
        if sectionsCount > 0 {
            let sectionInfo = fetchedResultsController.sections![indexPath.section]
            print("分组信息\(sectionInfo.name)")
            month = Int(sectionInfo.name)!
            
            
        }
        dvc.month = month
        dvc.year = year
        self.navigationController!.pushViewController(dvc, animated: true)
        
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
    func addGester(){
        let moreTap = UITapGestureRecognizer.init(target:self, action: #selector(DiaryYearCollectionViewController.back))
        moreTap.numberOfTapsRequired = 2//触发响应的点击次数
        self.view.addGestureRecognizer(moreTap)
        
        
    }
    @objc func back()
    {
        self.navigationController?.popViewController(animated: true)
    }
}
