//
//  SettingView.swift
//  HelpText
//
//  Created by yujaehong on 2023/10/30.
//

import SwiftUI

struct SettingView: View {
    
    var contactViewModel: ContactListViewModel
    var textMessageViewModel: TextMessageViewModel
    
    @State private var isPresentingContactListView = false
    @State private var showAlert = false
    @State private var showAlertForNegativeCount = false
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("문자 전송시 사용할 텍스트를 등록하세요.")) {
                    NavigationLink(destination: EditTextView(text: "", viewModel: textMessageViewModel)) {
                        Text("문자 전송 텍스트 등록하기")
                    }
                }
                
                Section(header: Text("연락처를 등록하세요.")) {
                    Button(action: {
                        isPresentingContactListView = true
                    }) {
                        Text("연락처 등록하기")
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    }
                    .sheet(isPresented: $isPresentingContactListView, onDismiss: {
                        
                    }, content: {
                        ContactListView(viewModel: contactViewModel)
                    })
                }
                
                Section(header: Text("등록한 연락처를 초기화 합니다.")) {
                    Button(action: {
                        if contactViewModel.selectedUsers.count > 0 {
                            showAlert = true
                        } else {
                            showAlertForNegativeCount = true
                        }
                    }) {
                        Text("등록된 연락처 초기화하기")
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("경고"),
                        message: Text("등록된 연락처를 초기화하시겠습니까?"),
                        primaryButton: .default(Text("확인"), action: {
                            contactViewModel.selectedUsers.removeAll()
                        }),
                        secondaryButton: .cancel(Text("취소"))
                    )
                }
                .alert(isPresented: $showAlertForNegativeCount) {
                    Alert(
                        title: Text("안내"),
                        message: Text("등록된 연락처가 없습니다."),
                        dismissButton: .default(Text("확인"))
                    )
                }
                
//                Section(header: Text("정보와 문의가 필요하다면 이곳을 확인해주세요.")) {
//                    NavigationLink(destination: DeveloperInfoView()) {
//                        Text("개발자 정보 보기 및 문의 바로가기")
//                    }
//                }
                
                
            }
            .navigationTitle("설정")
        }
    }
}
