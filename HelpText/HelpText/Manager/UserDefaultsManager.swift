//
//  UserDefaultsManager.swift
//  HelpText
//
//  Created by yujaehong on 2023/10/30.
//

import SwiftUI

class UserDefaultsManager {
    
    private enum Keys {
        static let names = "UserNames"
        static let text = "TextMessage"
    }
    
    static func saveUserNames(_ name: [String]) {
        UserDefaults.standard.set(name, forKey: Keys.names)
    }
    
    static func saveTextMessage(_ textMessage: String) {
        UserDefaults.standard.set(textMessage, forKey: Keys.text)
    }
    
    // UserDefaults에서 "UserNames" 키를 사용하여 저장된 배열을 가져와서 반환합니다. 반환 형식은 [String]?이며, 저장된 값이 없는 경우 nil을 반환할 수 있습니다.
    static func loadUserName() -> [String]? {
        return UserDefaults.standard.array(forKey: Keys.names) as? [String]
    }
    
    // UserDefaults에서 "TextMessage" 키를 사용하여 저장된 문자열을 가져와서 반환합니다. 반환 형식은 String?이며, 저장된 값이 없는 경우 nil을 반환할 수 있습니다.
    static func loadTextMessage() -> String? {
        return UserDefaults.standard.string(forKey: Keys.text)
    }
    
}

// 앱에서 간단한 데이터를 영구적으로 저장하고 불러올 수 있습니다.
// 예를 들어, 사용자 이름 목록이나 텍스트 메시지와 같은 설정 정보를 저장하는 데 사용할 수 있습니다.
