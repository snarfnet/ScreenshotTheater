import Foundation

enum TemplateStore {
    static let templates: [ChatTemplate] = [
        ChatTemplate(
            title: "告白された風",
            category: "告白された風",
            description: "急に距離が近くなる、青春っぽい架空チャット。",
            emoji: "💘",
            characterName: "となりの席の人",
            myName: "自分",
            messages: [
                .init(text: "今日ちょっと話せる？", isMe: false, time: "21:06", isRead: true),
                .init(text: "え、なに？", isMe: true, time: "21:07", isRead: true),
                .init(text: "ずっと言おうと思ってたことある", isMe: false, time: "21:08", isRead: true),
                .init(text: "急にドラマ始まった？", isMe: true, time: "21:08", isRead: true)
            ]
        ),
        ChatTemplate(
            title: "ホストDM風",
            category: "ホストDM風",
            description: "キラキラしすぎた架空DM。現実感は薄め。",
            emoji: "🥂",
            characterName: "夜の王子",
            myName: "姫",
            messages: [
                .init(text: "今日もえらいね、ちゃんと息してて天才", isMe: false, time: "23:11", isRead: false),
                .init(text: "褒め方が雑すぎる", isMe: true, time: "23:12", isRead: true),
                .init(text: "雑じゃないよ、ダイヤの原石って言ってる", isMe: false, time: "23:13", isRead: false)
            ]
        ),
        ChatTemplate(
            title: "芸能人から来た風",
            category: "芸能人から来た風",
            description: "名前は出さずに“有名っぽい人”から来た風。",
            emoji: "🌟",
            characterName: "公式っぽい人",
            myName: "自分",
            messages: [
                .init(text: "投稿見ました。センス、ありますね", isMe: false, time: "18:22", isRead: true),
                .init(text: "え、どなたですか？", isMe: true, time: "18:23", isRead: true),
                .init(text: "名乗るほどの者です", isMe: false, time: "18:24", isRead: true)
            ]
        ),
        ChatTemplate(
            title: "浮気バレ修羅場風",
            category: "修羅場風",
            description: "重すぎない、コント寄りの修羅場。",
            emoji: "🔥",
            characterName: "名探偵",
            myName: "容疑者",
            messages: [
                .init(text: "昨日、誰とラーメン行った？", isMe: false, time: "00:14", isRead: true),
                .init(text: "ラーメンとは限らない", isMe: true, time: "00:15", isRead: true),
                .init(text: "今、自白に近いこと言ったよ", isMe: false, time: "00:15", isRead: true),
                .init(text: "餃子も食べました", isMe: true, time: "00:16", isRead: true)
            ]
        ),
        ChatTemplate(
            title: "親から鬼通知風",
            category: "親から鬼通知風",
            description: "通知が止まらない家族チャット風。サービス名は使いません。",
            emoji: "📱",
            characterName: "母",
            myName: "自分",
            messages: [
                .init(text: "帰りに牛乳", isMe: false, time: "17:03", isRead: false),
                .init(text: "あと卵", isMe: false, time: "17:03", isRead: false),
                .init(text: "あと機嫌", isMe: false, time: "17:04", isRead: false),
                .init(text: "機嫌どこで売ってる？", isMe: true, time: "17:05", isRead: true)
            ]
        ),
        ChatTemplate(
            title: "先生から呼び出し風",
            category: "先生から呼び出し風",
            description: "怒られる直前みたいで、ちゃんと笑える。",
            emoji: "🏫",
            characterName: "担任",
            myName: "生徒",
            messages: [
                .init(text: "放課後、少し職員室へ", isMe: false, time: "14:41", isRead: true),
                .init(text: "心当たりが多すぎます", isMe: true, time: "14:42", isRead: true),
                .init(text: "その返事で一つ増えました", isMe: false, time: "14:43", isRead: true)
            ]
        ),
        ChatTemplate(
            title: "クラスチャット炎上風",
            category: "クラスチャット炎上風",
            description: "クラス全体がざわつく架空グループチャット。",
            emoji: "💥",
            characterName: "2-B作戦会議",
            myName: "自分",
            messages: [
                .init(text: "明日の小テスト、範囲どこ？", isMe: false, time: "20:30", isRead: true),
                .init(text: "小テストあるの？", isMe: true, time: "20:31", isRead: true),
                .init(text: "今このグループ全員止まった", isMe: false, time: "20:31", isRead: true),
                .init(text: "発見者みたいに言わないで", isMe: true, time: "20:32", isRead: true)
            ]
        ),
        ChatTemplate(
            title: "元カノから深夜DM風",
            category: "元カレ・元カノ風",
            description: "深夜テンションの架空DM。未練よりネタ強め。",
            emoji: "🌙",
            characterName: "元カノ",
            myName: "自分",
            messages: [
                .init(text: "まだ起きてる？", isMe: false, time: "02:08", isRead: true),
                .init(text: "通知で起きた", isMe: true, time: "02:09", isRead: true),
                .init(text: "じゃあ運命だね", isMe: false, time: "02:09", isRead: true),
                .init(text: "それは通知設定です", isMe: true, time: "02:10", isRead: true)
            ]
        )
    ]

    static func randomWork() -> ChatWork {
        let names = ["謎の同級生", "深夜の友達", "公式っぽい人", "母", "担任", "元カノ", "未来の自分", "となりの席の人"]
        let openers = ["今、変なこと言っていい？", "大ニュースです", "ちょっと確認なんだけど", "今日の件、話そう", "起きてる？"]
        let twists = ["冷蔵庫にプリンなかった？", "あなた、主役すぎる", "全員が同じ顔してた", "それ夢じゃなくて現実です", "通知だけで空気変わった"]
        let replies = ["情報量多い", "まず落ち着こう", "それは事件", "スクショ撮っていい？", "今のなしにできる？"]
        let endings = ["この会話、後世に残そう", "既読ついたから勝ち", "今日はここまでにしよ", "逆にアリかも", "伝説が始まった"]
        let times = ["07:12", "16:45", "21:09", "23:58", "02:06"]

        return ChatWork(
            title: "ランダム劇場",
            characterName: names.randomElement() ?? "友達",
            myName: "自分",
            messages: [
                .init(text: openers.randomElement() ?? "ねえ", isMe: false, time: times.randomElement() ?? "21:00", isRead: true),
                .init(text: replies.randomElement() ?? "なに？", isMe: true, time: times.randomElement() ?? "21:01", isRead: true),
                .init(text: twists.randomElement() ?? "事件です", isMe: false, time: times.randomElement() ?? "21:02", isRead: true),
                .init(text: endings.randomElement() ?? "完", isMe: true, time: times.randomElement() ?? "21:03", isRead: true)
            ],
            unreadBadgeCount: Int.random(in: 0...18),
            batteryLevel: Int.random(in: 12...99),
            backgroundStyle: [.midnight, .violet, .deepGray].randomElement() ?? .midnight,
            myBubbleStyle: [.neonPink, .electricBlue, .lime].randomElement() ?? .neonPink,
            theirBubbleStyle: [.deepGray, .violet, .whiteInk].randomElement() ?? .deepGray,
            characterIcon: ["😎", "💘", "🌙", "🔥", "🏫", "🥂", "👑"].randomElement() ?? "😎"
        )
    }

    static func work(from template: ChatTemplate) -> ChatWork {
        ChatWork(
            title: template.title,
            characterName: template.characterName,
            myName: template.myName,
            messages: template.messages,
            unreadBadgeCount: template.messages.filter { !$0.isRead }.count,
            characterIcon: template.emoji
        )
    }
}
