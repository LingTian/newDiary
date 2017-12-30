//
//  Helper.swift
//  firstApp
//
//  Created by XIAO WU on 30/12/2017.
//  Copyright © 2017 XIAO WU. All rights reserved.
//

import Foundation
import UIKit
func diaryButtonWith(text:String,
    fontSize:CGFloat,
    width:CGFloat,
    normalImageName:String,
    highlightedImageName:String
    ) -> UIButton{
    let button = UIButton(type: UIButtonType.custom)
    button.frame=CGRect(x:0,y:0,width:width,height:width)
    
    let font = UIFont(name:"TpldKhangXiDictTrial",size:fontSize)as UIFont!
    
    let textAttributes:[NSAttributedStringKey:AnyObject]=[NSAttributedStringKey.font: font!,  NSAttributedStringKey.foregroundColor:UIColor.white]
    
    let attributedText=NSAttributedString(string:text,attributes:textAttributes)
    button.setAttributedTitle(attributedText, for:UIControlState.normal)
    
    button.setBackgroundImage(UIImage(named:normalImageName), for: UIControlState.normal)
    button.setBackgroundImage(UIImage(named:highlightedImageName), for: UIControlState.highlighted)
    return button
    
    
}
