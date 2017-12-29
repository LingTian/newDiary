//
//  DiaryLayout.swift
//  firstApp
//
//  Created by XIAO WU on 28/12/2017.
//  Copyright © 2017 XIAO WU. All rights reserved.
//

import UIKit
let screenSize=UIScreen.main.bounds.size
  

class DiaryLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        let itemSize=CGSize(width:itemWidth,height:itemHeight)
        print(screenSize.height)
        print(screenSize.width)
        self.itemSize=itemSize
        self.minimumInteritemSpacing=2.0
        self.minimumLineSpacing=0
        self.sectionInset = UIEdgeInsets(
            top:(screenSize.height/2.0)-(itemHeight/2.0)-20.0,//content bar size
            left:(screenSize.width/2.0)-(itemWidth/2.0),
            bottom:(screenSize.height/2.0)-(itemHeight/2.0),
            right:(screenSize.width/2.0)-(itemWidth/2.0)
        )
    }
}
