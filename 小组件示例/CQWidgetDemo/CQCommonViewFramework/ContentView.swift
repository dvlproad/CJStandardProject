//
//  ContentView.swift
//  CQWidgetExtensionDemo
//
//  Created by qian on 2024/11/15.
//

import SwiftUI
import WidgetKit

public struct ContentView: View {
    @State private var displayText = "点击按钮更新文字"
    
    // 添加公共初始化方法
    public init() {
        // 如果需要的话，可以在这里添加初始化逻辑
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            Text(displayText)
                .font(.system(size: 18))

            Button("更新文字") {
                displayText = generateRandomChineseCharacter()
                
                // 判断是应用内点击还是桌面点击
                if UIApplication.shared.applicationState == .active {
                    // 应用内点击
                    print("在应用内点击")
                    let sharedDefaults = UserDefaults(suiteName: "group.your.app.group.identifier")
                    sharedDefaults?.set(displayText, forKey: "widgetEmoji")
                    sharedDefaults?.synchronize()
                    
                    // 刷新小组件
                    WidgetCenter.shared.reloadAllTimelines()
                } else {
                    // 桌面点击
                    print("在桌面点击")
                }
            }
        }
    }
    
    private func generateRandomChineseCharacter() -> String {
        // 中文字符的 Unicode 范围：0x4E00 ~ 0x9FA5
        let start = 0x4E00
        let end = 0x9FA5
        
        // 生成随机数
        let random = Int.random(in: start...end)
        
        // 将数字转换为对应的 Unicode 字符
        if let scalar = UnicodeScalar(random) {
            return String(scalar)
        }
        
        return "错误"
    }
}

#Preview {
    ContentView()
} 
