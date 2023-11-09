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
                    ContactPicker(selectedUsers: $viewModel.selectedUsers, isAddingUser: $isAddingUser)
                        .accentColor(Color.customColor)
                } else {
                    if viewModel.selectedUsers.count > 0 {
                        Text("아래의 사용자들에게 현재 나의 위치를\n 문자로 전송합니다.")
                            .multilineTextAlignment(.center)
                        List(viewModel.selectedUsers) { user in
                            Text(user.name)
                        }
                    } else {
                        Text("우측 상단의 추가 버튼을 클릭하여\n 원하는 사람을 선택해주세요 (최대 5명).")
                            .multilineTextAlignment(.center)
                    }
                }
            }
            .navigationBarItems(trailing: addButton)
        }
    }
    
    
    private var addButton: some View {
        Group {
            if !isAddingUser {
                Button("추가") {
                    isAddingUser.toggle()
                }
                .foregroundColor(Color(red: 249.0/255.0, green: 42.0/255.0, blue: 42.0/255.0, opacity: 0.85))
            } else {
                EmptyView()
            }
        }
    }
}


// 연락처 선택 화면을 표시하고 사용자가 연락처를 선택하면
// 해당 정보를 selectedUsers에 저장하며, isAddingUser 상태를 관리하여 화면을 업데이트합니다.
struct ContactPicker: UIViewControllerRepresentable {
    
    @Binding var selectedUsers: [Contact] // 선택된 연락처 정보를 저장하는 배열
    @Binding var isAddingUser: Bool // 연락처를 추가하고 있는지 여부
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = CNContactPickerViewController()
        viewController.delegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(selectedUsers: $selectedUsers, isAddingUser: $isAddingUser)
    }
    
    class Coordinator: NSObject, CNContactPickerDelegate { // 선택된 연락처 정보를 처리
        
        @Binding var selectedUsers: [Contact]
        @Binding var isAddingUser: Bool
        
        init(selectedUsers: Binding<[Contact]>, isAddingUser: Binding<Bool>) {
            _selectedUsers = selectedUsers
            _isAddingUser = isAddingUser
        }
        
        // 사용자가 연락처를 선택할 때 호출됩니다. 선택된 연락처의 정보를 가져와 Contact 구조체로 변환한 후, selectedUsers 배열에 추가합니다.
        func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
            let newContacts = contacts.map { contact in
                let name = CNContactFormatter.string(from: contact, style: .fullName) ?? ""
                let phoneNumber = contact.phoneNumbers.first?.value.stringValue ?? ""
                return Contact(name: name, phoneNumber: phoneNumber)
            }
            
            let uniqueNewContacts = Array(Set(newContacts))
            
            let remainingSpace = 5 - selectedUsers.count
            let contactsToAdd = min(remainingSpace, uniqueNewContacts.count)
            
            selectedUsers += uniqueNewContacts.prefix(contactsToAdd)
            
            isAddingUser = false
        }
        
        // 사용자가 연락처 선택을 취소할 때 호출됩니다. 이때 isAddingUser를 false로 설정하여 연락처 선택이 종료됨을 나타냅니다.
        func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
            isAddingUser = false
        }
        
    }
    
}


// 이 코드는 SwiftUI를 사용하여 연락처를 선택하고 관리하는 데 사용되며,
// 사용자가 최대 5명까지 선택한 연락처를 저장하고 나중에 이 연락처에 메시지를 보낼 수 있도록 합니다.
