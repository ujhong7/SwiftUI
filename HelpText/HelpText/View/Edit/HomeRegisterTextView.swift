//
//  RegisterTextView.swift
//  HelpText
//
//  Created by yujaehong on 2023/10/30.
//

import SwiftUI

struct HomeRegisterTextView: View {
    
    @State var text: String
    @State var isEditing: Bool = false
    
    var viewModel: TextMessageViewModel
    
    @Environment(\.presentationMode) var presentationMode //  화면을 모달로 표시하고 닫는 데 사용
    
    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $text)
                    .padding()
                    .onTapGesture {
                        isEditing = true
                    }
                    .accentColor(Color.customColor)
            }
            .navigationTitle("텍스트 등록하기")
            .navigationBarItems(trailing: saveButton)
            .onAppear(perform: {
                text = viewModel.textMessage
            })
            .onDisappear(perform: {
                viewModel.saveTextMessageToUserDefaults(text)
            })
        }
    }
    
    var saveButton: some View {
        Button(action: {
            viewModel.saveTextMessageToUserDefaults(text)
            isEditing = false
            presentationMode.wrappedValue.dismiss() // wrappedValue는 @Environment 속성에서 실제 값을 추출하는 데 사용되는 속성
        }, label: {
            Text("완료")
                .fontWeight(.regular)
                .accentColor(Color.customColor)
        })
        .disabled(!isEditing)
    }
    
}
