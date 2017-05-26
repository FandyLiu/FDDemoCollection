//
//  LocationManager.swift
//  CitySelection
//
//  Created by QianTuFD on 2017/5/23.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit
import CoreLocation


enum LocationError: CustomStringConvertible {
    case locationDisabled // 设备没开启定位功能
    case denied // 被拒绝
    public var description: String {
        switch self {
        case .locationDisabled:
            return "设备没开启定位功能"
        case .denied:
            return "被拒绝"
        }
    }
}


class FDLocationManager: NSObject {
    
    fileprivate static let shareInstance = FDLocationManager()
    
    private override init() { }
    
    fileprivate var success: ((String) -> ())?
    
    lazy var locationManager: CLLocationManager? = { [unowned self] in
        if CLLocationManager.locationServicesEnabled() {
            let locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = 10
            return locationManager
        }else {
            return nil
        }
     }()
    
    class func startUpdatingLocation(_ failure: (LocationError) -> (),_ success: @escaping (String) -> ()) {
        guard let locationManager = FDLocationManager.shareInstance.locationManager else {
            failure(LocationError.locationDisabled)
            return
        }
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            print("authorized")
        case .denied, .restricted:
            failure(LocationError.denied)
            return
        }
        FDLocationManager.shareInstance.success = success
        locationManager.startUpdatingLocation()
    }
    
    
    class func defaultAlertController() -> UIAlertController {
        let alertController = UIAlertController(title: "定位访问", message: "定位访问", preferredStyle: UIAlertControllerStyle.alert)
        let action0 = UIAlertAction(title: "设置", style: UIAlertActionStyle.default, handler: { (action) in
            guard let url = URL(string: UIApplicationOpenSettingsURLString) else {
                assertionFailure("UIApplicationOpenSettingsURLString 有可能被废弃了")
                return
            }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [UIApplicationOpenURLOptionUniversalLinksOnly: false], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        })
        let action1 = UIAlertAction(title: "好", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController.addAction(action0)
        alertController.addAction(action1)
        return alertController
    }
}

// MARK: - CLLocationManagerDelegate
extension FDLocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last!
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(currentLocation) { (placeMarks, error) in
            guard let placeMarks = placeMarks else {
                return
            }
            if placeMarks.count > 0 {
                let placeMark = placeMarks.first!
                if let currentCity = placeMark.locality {
                    FDLocationManager.shareInstance.success?(currentCity)
                    //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                    print(currentCity)
                }else if let currentCity = placeMark.administrativeArea {
                    FDLocationManager.shareInstance.success?(currentCity)
                    print(currentCity)
                }
//                print("没取值")
                manager.stopUpdatingLocation()
            }else {
                guard let err = error else {
                    print("定位失败")
                    return
                }
                print("定位失败" + err.localizedDescription)
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

