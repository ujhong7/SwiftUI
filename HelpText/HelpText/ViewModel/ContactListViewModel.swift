//
//  ContactListViewModel.swift
//  HelpText
//
//  Created by yujaehong on 2023/10/30.
//

import SwiftUI
import ContactsUI // 연락처 관련 기능을 구현

class ContactListViewModel: ObservableObject {

    @Published var selectedUsers: [Contact] = [] {
        didSet {
            saveSelectedUsers()
        }
    }
    
    init() {
        loadSelectedUsers()
    }
    
    private let selectedUsersKey = "selectedUsersKey"
    
    // 선택한 사용자를 저장하는 비공개 함수입니다. 선택한 사용자를 selectedUsers 배열에서 JSON 데이터로 인코딩하고, UserDefaults를 사용하여 저장합니다.
    private func saveSelectedUsers() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(selectedUsers) {
            UserDefaults.standard.set(encoded, forKey: selectedUsersKey)
        }
    }
    
    // 저장된 선택 사용자를 불러오는 함수입니다. UserDefaults에서 selectedUsersKey 키를 사용하여 저장된 데이터를 가져오고, 이 데이터를 디코딩하여 selectedUsers 배열에 할당합니다.
    private func loadSelectedUsers() {
        if let savedData = UserDefaults.standard.data(forKey: selectedUsersKey) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Contact].self, from: savedData) {
                selectedUsers = decoded
            }
        }
    }
    
}


// 이 ContactListViewModel 클래스를 사용하면 SwiftUI 앱에서 사용자가 선택한 연락처를 저장하고 불러올 수 있습니다.
// 선택한 사용자 목록은 앱을 종료하고 다시 열어도 유지됩니다.
// 앱의 다른 부분에서 이 ViewModel을 사용하여 사용자 인터페이스를 구성하고 선택한 연락처를 관리할 수 있을 것입니다.
