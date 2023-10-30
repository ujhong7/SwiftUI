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
        let store = CNContactStore()
        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: keysToFetch)
        
        var contactsInfo: [String] = []
        do {
            
        } catch {
            print("연락처 정보를 가져올 수 없습니다.")
        }
        
        completion(contactsInfo)
    }
    
    // SIM 카드 정보를 가져옴
    func requestSIMinfo(completion: @escaping (String) -> Void) {
        
    }
    
}

// 주소록 및 SIM 카드 정보와 관련된 작업을 처리하는 클래스입니다.
// 주로 Contacts 및 CoreTelephony 프레임워크를 사용하여 연락처와 SIM 카드 정보를 가져오는 기능을 제공합니다.

// 연락처 및 SIM 카드 정보를 앱에서 사용하는 데 도움을 주는 클래스로 사용될 수 있습니다.
// 앱에서 연락처를 가져오거나 SIM 카드 정보를 확인하는 데 필요한 로직을 간단히 구현하고 관리합니다.
