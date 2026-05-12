import Foundation
import SwiftUI

struct ChatMessage: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var text: String
    var isMe: Bool
    var time: String
    var isRead: Bool
}

struct ChatTemplate: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var title: String
    var category: String
    var description: String
    var emoji: String
    var characterName: String
    var myName: String
    var messages: [ChatMessage]
}

struct ChatWork: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var title: String
    var characterName: String
    var myName: String
    var messages: [ChatMessage]
    var createdAt: Date = Date()
    var unreadBadgeCount: Int = 3
    var showsReadStatus: Bool = true
    var batteryLevel: Int = 82
    var backgroundStyle: ChatColorStyle = .midnight
    var myBubbleStyle: ChatColorStyle = .neonPink
    var theirBubbleStyle: ChatColorStyle = .deepGray
    var characterIcon: String = "😎"
}

enum ChatColorStyle: String, CaseIterable, Identifiable, Codable {
    case midnight
    case neonPink
    case electricBlue
    case lime
    case violet
    case deepGray
    case whiteInk

    var id: String { rawValue }

    var label: String {
        switch self {
        case .midnight: "黒ネオン"
        case .neonPink: "ピンク"
        case .electricBlue: "ブルー"
        case .lime: "ライム"
        case .violet: "バイオレット"
        case .deepGray: "グレー"
        case .whiteInk: "白"
        }
    }

    var color: Color {
        switch self {
        case .midnight: Color(red: 0.04, green: 0.04, blue: 0.08)
        case .neonPink: Color(red: 1.0, green: 0.08, blue: 0.55)
        case .electricBlue: Color(red: 0.0, green: 0.75, blue: 1.0)
        case .lime: Color(red: 0.55, green: 1.0, blue: 0.12)
        case .violet: Color(red: 0.58, green: 0.22, blue: 1.0)
        case .deepGray: Color(red: 0.14, green: 0.15, blue: 0.19)
        case .whiteInk: Color.white
        }
    }

    var foreground: Color {
        switch self {
        case .lime, .whiteInk: .black
        default: .white
        }
    }
}
