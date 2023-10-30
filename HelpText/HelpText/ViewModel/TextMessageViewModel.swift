//
//  TextMessageViewModel.swift
//  HelpText
//
//  Created by yujaehong on 2023/10/30.
//

import SwiftUI
import Combine // 비동기 및 이벤트 기반 프로그래밍을 지원하는 라이브러리, 상태 관리 및 데이터 흐름 처리에 사용

class TextMessageViewModel: ObservableObject {
    
    // @Published 속성 래퍼를 사용하여 이 속성의 변경 사항을 자동으로 감지하고 뷰를 업데이트
    @Published var textMessage: String = ""
    
    init () {
        loadTextMessageToUserDefaults()
    }
    
    private let savedText = "savedText"
    
    func saveTextMessageToUserDefaults(_ newText: String) {
        textMessage = newText;
        UserDefaults.standard.set(textMessage, forKey: savedText)
    }
    
    func loadTextMessageToUserDefaults() {
        if let savedData = UserDefaults.standard.string(forKey: savedText) {
            textMessage = savedData
        }
    }
    
}

// 이 TextMessageViewModel은 SwiftUI 앱에서 사용자의 텍스트 메시지를 저장하고 불러올 수 있는 도구입니다.
// 뷰에서 이 ViewModel을 사용하면 사용자의 입력을 저장하고 불러오는 데 도움이 됩니다.

// ⭐️⭐️⭐️
// saveTextMessage -> saveTextMessageToUserDefaults
// loadTextMessage -> loadTextMessageToUserDefaults
