//
//  LocationManager.swift
//  HelpText
//
//  Created by yujaehong on 2023/10/30.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    private let locationManager = CLLocationManager() // Core Location 프레임워크에서 제공하는 위치 정보 관리를 위한 클래스
    
    @Published var currentLocation: String? // 사용자의 현재 위치 정보를 저장하기 위한 @Published 속성, 변경사항이 발생할 때마다 관련된 SwiftUI 뷰에 알림이 전달 함으로써 뷰가 업데이트
    
    // 클래스가 다른 클래스를 상속하거나 프로토콜을 준수할 때, 해당 클래스나 프로토콜의 초기화 메서드를 재정의할 수 있습니다.
    // 기존의 초기화 동작을 수정하거나 확장하는 데 사용됩니다.
    // 설정 및 위치 업데이트를 시작하는 작업을 수행하기 위해 init 메서드를 재정의
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // 위치 업데이트가 발생하면 호출되는 메서드
    // 현재 위치 정보를 가져오고 주소로 변환하는 역할
    // locationManager -> fetchUserLocation 🔴
    func fetchUserLocation(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { // 🔴
        
        let geocoder = CLGeocoder() // 위치 정보를 주소로 변환
        
        if let location = locations.last {
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in // 현재 위치 정보를 주소로 변환하고, 주소 정보를 placemarks에 저장
                if let error = error {
                    print("Reverse geocoding error: \(error.localizedDescription)")
                    return
                }
                
                if let placemark = placemarks?.first {
                    var address = ""
                    
                    if let administrativeArea = placemark.administrativeArea {
                        address = "\(address) \(administrativeArea)"
                    }
                    
                    if let locality = placemark.locality {
                        address = "\(address) \(locality)"
                    }
                    
                    if let thoroughfare = placemark.thoroughfare {
                        address = "\(address) \(thoroughfare)"
                    }
                    
                    if let subThoroughfare = placemark.subThoroughfare {
                        address = "\(address) \(subThoroughfare)"
                    }
                    
                    self.currentLocation = address // 주소 정보를 currentLocation 속성에 할당
                }
            }
        }
        
    }
    
}

// LocationManager 클래스가 사용자의 현재 위치를 가져오고 주소로 변환하여
// @Published 속성을 통해 SwiftUI 뷰에 현재 위치를 표시하는 데 사용됩니다.
