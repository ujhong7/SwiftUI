//
//  HomeView.swift
//  HelpText
//
//  Created by yujaehong on 2023/10/30.
//

import SwiftUI

struct HomeView: View {
    
    // @StateObject 속성 래퍼를 사용하여 해당 인스턴스를 홈 뷰의 수명 주기 동안 유지
    @StateObject private var locationManager = LocationManager()
    @StateObject private var messageManager = MessageManager()
    
    var contactViewModel: ContactListViewModel
    var textMessageViewModel: TextMessageViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Help Text")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                Image("SAVEME_ICON")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .cornerRadius(12)
            }
            .padding(.all, 30)
            VStack(spacing: 20) {
                HomeSection1View(contactViewModel: contactViewModel, textMessageViewModel: textMessageViewModel)
                HomeSection2View(contactViewModel: contactViewModel, textMessageViewModel: textMessageViewModel)
            }
        }
        .background(Color(.systemBackground))
    }
    
}

// 코드의 중요한 부분은 @StateObject로 관찰 가능한 객체를 만들고, 이러한 객체를 사용하여 뷰의 상태와 동작을 관리하는 것입니다.
// 또한 HomeSection1View 및 HomeSection2View는 해당 뷰의 일부분으로, 뷰를 구성하는 더 작은 컴포넌트 뷰를 나타냅니다.
