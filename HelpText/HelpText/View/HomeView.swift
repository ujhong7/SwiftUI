//
//  HomeView.swift
//  HelpText
//
//  Created by yujaehong on 2023/10/30.
//

import SwiftUI

struct HomeView: View {
    
    // @StateObject 속성 래퍼를 사용하여 해당 인스턴스를 홈 뷰의 수명 주기 동안 유지
    @StateObject private var locationManager = locationManager()
    @StateObject private var messageManager = messageManager()
    
    var contactViewModel: ContactListViewModel
    var textMessageViewModel: TextMessageViewModel
    
    var body: some View {
        
    }
    
}
