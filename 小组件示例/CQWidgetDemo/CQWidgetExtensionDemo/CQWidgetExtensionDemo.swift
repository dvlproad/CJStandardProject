//
//  CQWidgetExtensionDemo.swift
//  CQWidgetExtensionDemo
//
//  Created by qian on 2024/11/15.
//

import WidgetKit
import SwiftUI
import CQCommonViewFramework

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        
        let sharedDefaults = UserDefaults(suiteName: "group.your.app.group.identifier")
        let emoji = sharedDefaults?.string(forKey: "widgetEmoji") ?? "默认表情"
        
        for secondOffset in 0 ..< 12 {
            let entryDate = Calendar.current.date(byAdding: .second, value: secondOffset*5, to: currentDate)!
            let updatedConfig = configuration
            updatedConfig.favoriteEmoji = emoji
            let entry = SimpleEntry(date: entryDate, configuration: updatedConfig)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct CQWidgetExtensionDemoEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Time:")
            Link(destination: URL(string: "https://www.link2.com")!, label: {
                Text("链接2").foregroundColor(.blue)
            })
            Text(entry.date.formatted(.dateTime
                .year().month().day()
                .hour().minute().second()
            ))

//            Text("Favorite Emoji:")
            Text(entry.configuration.favoriteEmoji)
            
            ContentView()
        }
    }
}

struct CQWidgetExtensionDemo: Widget {
    let kind: String = "CQWidgetExtensionDemo"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            CQWidgetExtensionDemoEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .supportedFamilies([.systemMedium, .systemLarge])  // 配置该组件支持的尺寸，如果不配置，默认是大中小都支持
        .configurationDisplayName("组件标题")   // 在添加组件预览界面显示
        .description("组件描述")                 // 在添加组件预览界面显示
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    CQWidgetExtensionDemo()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
