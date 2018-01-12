//
//  DiaryLocationHelper.swift
//  firstApp
//
//  Created by XIAO WU on 10/01/2018.
//  Copyright © 2018 XIAO WU. All rights reserved.
//

import Foundation

import CoreLocation

class DiaryLocationHelper: NSObject, CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager = CLLocationManager()
    var currentLocation:CLLocation?
    var address:String?
    var geocoder = CLGeocoder()
    
    override init() {
        super.init()
        // 设置委托
        locationManager.delegate = self
        // 请求位置授权
        locationManager.requestWhenInUseAuthorization()
        if (CLLocationManager.locationServicesEnabled()){
            //开始获取位置
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 根据经纬度查询位置名称
        geocoder.reverseGeocodeLocation(locations[0], completionHandler: { (placemarks, error) in
            
            if let error = error {
                print("查询失败: \(error.localizedDescription)")
            }
            
            // placemarks里包括了位置的国家、省份、地区等信息
            if let pm = placemarks {
                if pm.count > 0 {
                    
                    let placemark = pm.first
                    
                    self.address = placemark?.locality
                    
                    // 广播位置信息
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "DiaryLocationUpdated"), object: self.address)
                }
            }
            
        })
    }
    
}
