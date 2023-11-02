//
//  RootView.swift
//  HelpText
//
//  Created by yujaehong on 2023/10/30.
//

import SwiftUI

struct RootView: View {
    
    // @ObservedObject를 통해 이러한 뷰 모델들을 관찰합니다.
    // 뷰가 뷰 모델의 변경사항을 관찰하고 이를 반영할 수 있습니다.
    @ObservedObject var contactViewModel = ContactListViewModel()
    @ObservedObject var textMessageViewModel = TextMessageViewModel()
    
    var body: some View {
        TabView {
            HomeView(contactViewModel: contactViewModel, textMessageViewModel: textMessageViewModel)
                .tabItem {
                    Image(systemName: "house")
                    Text("홈")
                }
            SettingView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("설정")
                }
        }
        //  전체 앱의 강조 색상을 설정합니다. 이 코드에서는 사용자 지정 색상을 정의하고 이를 사용하여 앱의 강조 색상을 지정합니다.
        .accentColor(.init(uiColor: UIColor(red: 249.0/255.0, green: 42.0/255.0, blue: 42.0/255.0, alpha: 1)))
        // 사용하여 뷰가 나타날 때의 동작을 설정합니다. 이 코드에서는 탭 바의 배경색을 시스템 기본 배경 색상으로 설정합니다.
        .onAppear {
            UITabBar.appearance().backgroundColor = .systemBackground
        }
    }
    
}

// RootView는 앱의 루트 뷰로 사용되며, 탭 뷰를 포함하고 "홈"과 "설정" 탭을 표시합니다.
// 각 탭에는 HomeView 및 SettingView가 포함되어 각 탭에 대한 화면을 구성합니다. 또한 강조 색상과 탭 바의 배경색을 사용자 지정합니다.
