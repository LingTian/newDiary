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
    
    let font = UIFont(name:"Wyue-GutiFangsong-NC",size:fontSize)as UIFont!
    
    let textAttributes:[NSAttributedStringKey:AnyObject]=[NSAttributedStringKey.font: font!,  NSAttributedStringKey.foregroundColor:UIColor.white]
    
    let attributedText=NSAttributedString(string:text,attributes:textAttributes)
    button.setAttributedTitle(attributedText, for:UIControlState.normal)
    
    button.setBackgroundImage(UIImage(named:normalImageName), for: UIControlState.normal)
    button.setBackgroundImage(UIImage(named:highlightedImageName), for: UIControlState.highlighted)
    return button
    
    
}

func numberToChinese(_ number:Int) -> String {
    let numbers = Array(String(number))
    var finalString = ""
    for singleNumber in numbers {
        let string = singleNumberToChinese(singleNumber)
        finalString = "\(finalString)\(string)"
    }
    return finalString
}

func numberToChineseWithUnit(_ number:Int) -> String {
    let numbers = Array(String(number))
    var units = unitParser(numbers.count)
    var finalString = ""
    
    for (index, singleNumber) in numbers.enumerated() {
        let string = singleNumberToChinese(singleNumber)
        if (!(string == "零" && (index+1) == numbers.count)){
            finalString = "\(finalString)\(string)\(units[index])"
        }
    }
    
    return finalString
}

func unitParser(_ unit:Int) -> [String] {
    
    var units = Array(["万","千","百","十",""].reversed())
    let parsedUnits = units[0..<(unit)].reversed()
    let slicedUnits: ArraySlice<String> = ArraySlice(parsedUnits)
    let final: [String] = Array(slicedUnits)
    return final
}

func singleNumberToChinese(_ number:Character) -> String {
    switch number {
    case "0":
        return "零"
    case "1":
        return "一"
    case "2":
        return "二"
    case "3":
        return "三"
    case "4":
        return "四"
    case "5":
        return "五"
    case "6":
        return "六"
    case "7":
        return "七"
    case "8":
        return "八"
    case "9":
        return "九"
    default:
        return ""
}
}
