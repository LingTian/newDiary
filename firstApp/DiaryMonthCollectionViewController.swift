//
//  DiaryYearCollectionViewController.swift
//  firstApp
//
//  Created by XIAO WU on 29/12/2017.
//  Copyright © 2017 XIAO WU. All rights reserved.
//

import UIKit
import CoreData

let DiaryRed = UIColor.init(red: 255/255.0, green: 23/255.0, blue: 23/255.0, alpha: 1)

class DiaryMonthCollectionViewController: UICollectionViewController {
    var year: Int!
    var month: Int!
    var yearLabel:DiaryLabel!
    var monthLabel:DiaryLabel!
    var fetchedResultsController: NSFetchedResultsController<Diary>!
    var diarys = [Diary]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let layout=DiaryLayout()
        addGester()
        layout.scrollDirection=UICollectionViewScrollDirection.horizontal
        self.collectionView?.setCollectionViewLayout(layout, animated:false)
        
        yearLabel = DiaryLabel(
            fontname:"Wyue-GutiFangsong-NC",
            labelText:"二零一五年",
            fontSize:16.0,
            lineHeight:5.0,
          color:UIColor.black
        )
        yearLabel.frame = CGRect(x:screenSize.width-yearLabel.frame.size.width-20,
                                 y:20,
                                 width:yearLabel.frame.size.width,
                                 height:yearLabel.frame.size.height
        
        )
        self.view.addSubview(yearLabel)
        
        monthLabel = DiaryLabel(
            fontname:"Wyue-GutiFangsong-NC",
            labelText:"三月",
            fontSize:16.0,
            lineHeight:5.0,
            color:DiaryRed
        )
        monthLabel.frame = CGRect(x:screenSize.width-monthLabel.frame.size.width-20,
                                 y:screenSize.height/2.0-monthLabel.frame.size.height/2.0,
                                 width:monthLabel.frame.size.width,
                                 height:monthLabel.frame.size.height
            
        )
        self.view.addSubview(monthLabel)
        
        //btn
        let composeButton = diaryButtonWith(
            text:"撰",
            fontSize:14.0,
            width:40.0,
            normalImageName:"btn_normal",
            highlightedImageName:"btn_hl"
                                            )
        composeButton.addTarget(self, action: #selector(newCompose), for: UIControlEvents.touchUpInside)
        composeButton.center = CGPoint(x:yearLabel.center.x,y:38+yearLabel.frame.size.height+26.0/2.0)
        self.view.addSubview(composeButton)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
   //     self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        do {
            // 新建查询
            let fetchRequest = NSFetchRequest<Diary>(entityName:"Diary")
            
            //filter
            fetchRequest.predicate = NSPredicate(format: "year = \(year!) AND month = \(month!)")
            
            // 排序方式
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "created_at", ascending: true)]
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: managedContext, sectionNameKeyPath: nil,
                                                                  cacheName: nil)
            
            // 尝试查询
            try self.fetchedResultsController.performFetch()
            
            if (fetchedResultsController.fetchedObjects!.count == 0){
                print("没有存储结果")
            }else{
                    diarys = fetchedResultsController.fetchedObjects!
            }
            resetCollectionView()
        } catch let error as NSError {
            NSLog("发现错误 \(error.localizedDescription)")
        }
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
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return diarys.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier="DiaryCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)as! DiaryCell
        let diary = diarys[indexPath.row]
        cell.labelText=diary.title!
        
        // Configure the cell
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        let identifier="DiaryViewController"
        let dvc = self.storyboard?.instantiateViewController(withIdentifier: identifier)as! DiaryViewController
        
      //  dvc.year=2015
        dvc.diary = diarys[indexPath.row]
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
    func callInsets(numberOfCells: Int) -> UIEdgeInsets{
        let insetLeft = (screenSize.width - collectionViewWidth)/2.0
        var edgeInsets: CGFloat = 0
        if(numberOfCells >= 3){
            edgeInsets = insetLeft
        }else {
            edgeInsets = insetLeft + (collectionViewWidth - (CGFloat(numberOfCells)*itemWidth))/2.0
        }
        return UIEdgeInsets(top:(screenSize.height/2.0) - (itemHeight/2.0),left:edgeInsets,bottom:(screenSize.height/2.0) - (itemHeight/2.0),right:0)
        
    }
    @objc func resetCollectionView(){
        
        let edgeInsets = callInsets(numberOfCells: diarys.count)
        
        if let layout = collectionView!.collectionViewLayout as? DiaryLayout {
            layout.edgeInsets = edgeInsets.left
        }
        
        self.collectionView!.contentOffset = CGPoint(x: -edgeInsets.left, y: 0)
        
        self.collectionView!.reloadData()
        
        view.layoutIfNeeded()
    }
    func addGester(){
        let moreTap = UITapGestureRecognizer.init(target:self, action: #selector(DiaryYearCollectionViewController.back))
        moreTap.numberOfTapsRequired = 2//触发响应的点击次数
        self.view.addGestureRecognizer(moreTap)
        
        
    }
    @objc func back()
    {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func newCompose(){
        let identifier = "DiaryComposeViewController"
        let composeViewController = self.storyboard?.instantiateViewController(withIdentifier: identifier) as! DiaryComposeViewController
        self.present(composeViewController,animated: true,completion: nil)
        
    }
}
