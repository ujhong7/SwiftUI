//
//  EditTextView.swift
//  HelpText
//
//  Created by yujaehong on 2023/10/30.
//

import SwiftUI

struct EditTextView: View {
    
    @State var text: String
    @State var isEditing: Bool = false
    
    var viewModel: TextMessageViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            TextEditor(text: $text)
                .padding()
                .onTapGesture {
                    isEditing = true
                }
        }
        .navigationTitle("메세지 작성")
        .navigationBarItems(trailing: saveButton)
        .onAppear(perform: {
                text = viewModel.textMessage
        })
        .onDisappear(perform: {
            viewModel.saveTextMessageToUserDefaults(text)
        })
    }
    
    var saveButton: some View {
        Button(action: {
            viewModel.saveTextMessageToUserDefaults(text)
            isEditing = false
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("완료")
                .fontWeight(.regular)
        })
        .disabled(!isEditing)
    }
}
