//
//  ContactListView.swift
//  HelpText
//
//  Created by yujaehong on 2023/10/30.
//

import SwiftUI
import ContactsUI


// Identifiable 프로토콜 준수: 이 프로토콜은 각 데이터 요소가 고유한 식별자(id)를 가져야 함을 나타냅니다.
// Contact 구조체는 id 필드를 UUID로 설정하여 각 연락처 요소가 고유한 식별자를 가지도록 합니다.
// Codable 프로토콜 준수: Codable 프로토콜은 데이터를 인코딩(직렬화) 및 디코딩(역직렬화)할 수 있는 능력을 제공합니다.
// 이것은 데이터를 다른 형식으로 변환하고 저장하거나 다시 불러올 때 사용됩니다.

// 사용자의 연락처 정보를 나타냅니다.
struct Contact: Identifiable, Codable, Hashable {
    let id = UUID()
    let name: String
    let phoneNumber: String
    
    // encode(to:) 메서드: 이 메서드는 Encoder를 사용하여 데이터를 인코딩하는 데 사용됩니다. 
    // encode(to:) 메서드 내에서는 container를 생성하고, 데이터 필드를 CodingKeys를 사용하여 해당 컨테이너에 인코딩합니다.
    // 여기에서 name 및 phoneNumber 필드가 인코딩됩니다
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(phoneNumber, forKey: .phoneNumber)
    }
    
    // enum CodingKeys: 이 열거형은 데이터 필드와 해당 인코딩 및 디코딩 키를 정의하는 데 사용됩니다.
    // 이 열거형은 String 형식의 rawValue를 가지며, name 및 phoneNumber이라는 두 가지 케이스를 가지고 있습니다.
    // 이러한 케이스는 데이터 필드의 이름과 일치합니다.
    enum CodingKeys: String, CodingKey {
        case name
        case phoneNumber
    }
}

// 사용자의 연락처 목록을 표시하고, 사용자가 추가 버튼을 눌러 연락처를 선택하거나 선택한 연락처 목록을 표시합니다.
struct ContactListView: View {
    @State private var isAddingUser = false
    @ObservedObject var viewModel: ContactListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if isAddingUser {
                    ContactPicker()
                } else {
                    if viewModel.selectedUsers
                }
            }
        }
    }
}

// 사용자가 연락처를 선택한 후 호출되며, 선택한 연락처를 가져와서 Contact 객체로 변환한 후 selectedUsers에 추가합니다.
// 최대 5개까지만 연락처를 추가할 수 있습니다.
struct ContactPicker: UIViewControllerRepresentable {
    
}


// 이 코드는 SwiftUI를 사용하여 연락처를 선택하고 관리하는 데 사용되며,
// 사용자가 최대 5명까지 선택한 연락처를 저장하고 나중에 이 연락처에 메시지를 보낼 수 있도록 합니다.
