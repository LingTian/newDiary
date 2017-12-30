//
//  HomeYearCollectionViewCell.swift
//  firstApp
//
//  Created by XIAO WU on 28/12/2017.
//  Copyright © 2017 XIAO WU. All rights reserved.
//

import UIKit

class DiaryCell: UICollectionViewCell {
    var textLabel:DiaryLabel!
    var textInt:Int = 0
    var labelText:String=""{
        didSet{
            textLabel.updateText(labelText:labelText)
          
            print(labelText)
        }
        
    }
    override func awakeFromNib() {
    
            super.awakeFromNib()
       
            self.textLabel=DiaryLabel(
                fontname:"Wyue-GutiFangsong-NC",
                labelText:self.labelText,
                fontSize:16.0,
                lineHeight:5.0,
                color:UIColor.black
        )
        
            self.contentView.addSubview(self.textLabel)
            
            
        
        
    }
        override func layoutSubviews(){
            super.layoutSubviews()
            self.textLabel.center=CGPoint(x:itemWidth/2.0,y:100.0/2.0)
            
        }
        
    }
    

