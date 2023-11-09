//
//  HomeSection2View.swift
//  HelpText
//
//  Created by yujaehong on 2023/10/30.
//

import SwiftUI

struct HomeSection2View: View {
    
    var contactViewModel: ContactListViewModel
    var textMessageViewModel: TextMessageViewModel
    
    @State private var isPresentingContactListView = false
    @State private var isTest = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("바로가기")
                .padding(.leading, 20)
                .font(.system(size: 25, weight: .bold))
            
            HStack(spacing: 0) {
                ActionButton2(title: "텍스트 등록하기",
                             subtitle: "문자 전송시 필요한 텍스트를\n설정할 수 있습니다.") {
                    isTest = true
                }.sheet(isPresented: $isTest, onDismiss: {
                    
                }, content: {
                    HomeRegisterTextView(text: "", viewModel: textMessageViewModel)
                })
                
                ActionButton2(title: "번호 등록하기",
                             subtitle: "연락처를 기반으로 원하는 사람을 등록할 수 있습니다.") {
                    isPresentingContactListView = true
                }.sheet(isPresented: $isPresentingContactListView, onDismiss: {
                    
                }, content: {
                    ContactListView(viewModel: contactViewModel)
                })
            }
        }
        .padding(.horizontal, 20)
        .background(Color(.systemBackground))
    }
    
}
