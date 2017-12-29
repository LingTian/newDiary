//
//  DiaryLabel.swift
//  firstApp
//
//  Created by XIAO WU on 28/12/2017.
//  Copyright © 2017 XIAO WU. All rights reserved.
//

import UIKit


import UIKit

func sizeHeightWithText(labelText: String,
                        fontSize: CGFloat,
                        textAttributes: [NSAttributedStringKey : AnyObject]) -> CGRect {
    
    return labelText.boundingRect(
        with: CGSize(width:fontSize, height:480),
        options: NSStringDrawingOptions.usesLineFragmentOrigin,
        attributes: textAttributes, context: nil)
}

class DiaryLabel: UILabel {
    
    var textAttributes: [NSAttributedStringKey : AnyObject]!
    
    convenience init(fontname:String,
                     labelText:String,
                     fontSize : CGFloat,
                     lineHeight: CGFloat,
                     color:UIColor
        ){
        
        self.init(frame: CGRect(x:0, y:0, width:0, height:0))
        
        let font = UIFont(name: fontname,
                          size: fontSize) as UIFont!
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight
        
        textAttributes = [NSAttributedStringKey.font: font!,
                          NSAttributedStringKey.foregroundColor:color,
                          NSAttributedStringKey.paragraphStyle: paragraphStyle]
        
        let labelSize = sizeHeightWithText(labelText: labelText,
                                           fontSize: fontSize ,
                                           textAttributes: textAttributes)
        
        self.frame = CGRect(x: 0, y: 0, width: labelSize.width,
                            height: labelSize.height)
        
        self.attributedText = NSAttributedString(
            string: labelText,
            attributes: textAttributes)
        self.lineBreakMode = NSLineBreakMode.byCharWrapping
        self.numberOfLines = 0
    }
    
    func updateText(labelText: String) {
        
        let labelSize = sizeHeightWithText(labelText: labelText,
                                           fontSize: self.font.pointSize,
                                           textAttributes: textAttributes)
        
        self.frame = CGRect(x:0,y: 0, width:labelSize.width,
                            height:labelSize.height)
        
        self.attributedText = NSAttributedString(
            string: labelText,
            attributes: textAttributes)
    }
    
}
