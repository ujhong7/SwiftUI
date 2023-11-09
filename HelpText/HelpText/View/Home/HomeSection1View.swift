//
//  HomeSection1View.swift
//  HelpText
//
//  Created by yujaehong on 2023/10/30.
//

import SwiftUI

struct HomeSection1View: View {
    
    @StateObject private var locationManager = LocationManager()
    @StateObject private var messageManager = MessageManager()
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertSubtitle = ""
    
    @State private var isLoading = false
    
    var contactViewModel: ContactListViewModel
    var textMessageViewModel: TextMessageViewModel
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("문자보내기")
                .padding(.leading, 20)
                .font(.system(size: 25, weight: .bold))
            
            ActionButton(title: "클릭하여 바로가기", subtitle: "📍 현재 나의 위치\n☎️ 등록된 번호\n📝 등록된 텍스트\n\n 위를 기반으로 메세지를 만들어 드립니다.") {
                tapActionButton()
            }
        }
        .padding(.horizontal, 20)
        .background(Color(.systemBackground))
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertSubtitle), dismissButton: .default(Text("확인"), action: {
                isLoading = false
            }))
        }
        .overlay( // 로딩 중에 화면을 가리기 위한 부분. isLoading이 true일 때 원형 로딩 인디케이터(ProgressView)가 표시되고, 화면을 덮도록 설정.
            ZStack(alignment: .center) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color(red: 249.0/255.0, green: 42.0/255.0, blue: 42.0/255.0, opacity: 0.85)))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
                .animation(.easeOut, value: 1)
        )
        
    }
    
    private func tapActionButton() {
        
        isLoading = true
        
        guard contactViewModel.selectedUsers.count > 0 else {
            alertTitle = "저장된 번호가 없습니다."
            alertSubtitle = "'홈 > 번호 등록하기' 를 진행해주세요."
            isLoading = false
            showAlert = true
            return
        }
        
        guard textMessageViewModel.textMessage.count > 0 else {
            alertTitle = "저장된 텍스트가 없습니다."
            alertSubtitle = "'홈 > 텍스트 등록하기' 를 진행해주세요."
            isLoading = false
            showAlert = true
            return
        }
        
        guard let location = locationManager.currentLocation else {
            alertTitle = "위치 정보 오류가 있습니다."
            alertSubtitle = "'설정 > 앱 > 위치' 접근 허용을 확인해주세요."
            isLoading = false
            showAlert = true
            return
        }
        
        messageManager.sendSMS(names: contactViewModel.selectedUsers, text: textMessageViewModel.textMessage, location: location) { result in
            
            isLoading = false
            
            if result == false {
                alertTitle = "메세지 생성에 실패했습니다."
                alertSubtitle = ""
                showAlert = true
            }
        }
        
    }
    
}
