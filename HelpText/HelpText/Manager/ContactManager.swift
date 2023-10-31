//
//  ContactManager.swift
//  HelpText
//
//  Created by yujaehong on 2023/10/30.
//

import CoreTelephony
import Contacts

class ContactManager: ObservableObject {
    
    // 연락처 접근 권한을 요청
    func requestContactsAccess(completion: @escaping (Bool) -> Void) {
        CNContactStore().requestAccess(for: .contacts) { granted, error in
            completion(granted)
        }
    }
    
    //  연락처 정보를 가져옴
    func fetchContacts(completion: @escaping ([String]) -> Void) {
        let store = CNContactStore() // 주소록 데이터를 관리하기 위한 클래스
        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor] // 주소록에서 가져올 정보를 지정하는데 사용되는 키의 배열
        let request = CNContactFetchRequest(keysToFetch: keysToFetch) //  주소록에서 정보를 가져올 때 사용하는 요청을 나타내는 객체
        
        var contactsInfo: [String] = [] // 가져온 연락처 정보를 저장하는 문자열 배열
        do {
            try store.enumerateContacts(with: request) { (contact, stop) in // 주소록에서 연락처 정보를 가져오는 루프를 시작
                let firstName = contact.givenName
                let lastName = contact.familyName
                
                if let phoneNumbers = contact.phoneNumbers.first?.value { // 현재 연락처의 전화번호를 가져오는 부분입니다. 만약 연락처에 전화번호가 있다면, phoneNumbers에 해당 정보가 저장
                    let phoneNumber = phoneNumbers.stringValue
                    contactsInfo.append("\(firstName) \(lastName): \(phoneNumber)") // 이름, 성, 및 전화번호를 조합하여 contactsInfo 배열에 추가
                } else {
                    contactsInfo.append("\(firstName) \(lastName): No phone number")
                }
            }
        } catch { // 만약 어떤 이유로든 주소록 정보를 가져올 수 없는 경우
            print("연락처 정보를 가져올 수 없습니다.")
        }
        
        completion(contactsInfo)
    }
    
    // SIM 카드 정보를 가져옴
    func requestSIMinfo(completion: @escaping (String) -> Void) {
        let networkInfo = CTTelephonyNetworkInfo()
        if let carrier = networkInfo.subscriberCellularProvider {
            let carrierName = carrier.carrierName ?? "Unknown"
            let countryCode = carrier.isoCountryCode ?? "Unknown"
            let mobileCountryCode = carrier.mobileCountryCode ?? "Unknown"
            let mobileNetworkCode = carrier.mobileNetworkCode ?? "Unknown"
            
            let simInfo = """
            Carrier Name: \(carrierName)
            ISO Country Code: \(countryCode)
            Mobile Country Code: \(mobileCountryCode)
            Mobile Network Code: \(mobileNetworkCode)
            """
            
            completion(simInfo)
        } else {
            completion("SIM 카드 정보를 가져올 수 없습니다.")
        }
    }
    
}

// 주소록 및 SIM 카드 정보와 관련된 작업을 처리하는 클래스입니다.
// 주로 Contacts 및 CoreTelephony 프레임워크를 사용하여 연락처와 SIM 카드 정보를 가져오는 기능을 제공합니다.

// 연락처 및 SIM 카드 정보를 앱에서 사용하는 데 도움을 주는 클래스로 사용될 수 있습니다.
// 앱에서 연락처를 가져오거나 SIM 카드 정보를 확인하는 데 필요한 로직을 간단히 구현하고 관리합니다.
