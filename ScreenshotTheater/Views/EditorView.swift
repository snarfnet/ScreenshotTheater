import SwiftUI
import UIKit

struct EditorView: View {
    @EnvironmentObject private var store: WorkStore
    @State private var work: ChatWork
    @State private var showShareSheet = false
    @State private var shareImage: UIImage?
    @State private var saveMessage: String?
    init(work: ChatWork, startsWithAd: Bool = false) {
        _work = State(initialValue: work)
    }

    var body: some View {
        VStack(spacing: 0) {
            BannerAdView(adUnitID: AdUnitID.top)
                .frame(height: 50)

            ZStack {
                AppBackground()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        ChatPreviewView(work: work)
                            .frame(height: 520)
                            .shadow(color: .cyan.opacity(0.22), radius: 18)

                        editForm
                        messageEditor
                        actionButtons
                    }
                    .padding(16)
                }
            }

            BannerAdView(adUnitID: AdUnitID.bottom)
                .frame(height: 50)
        }
        .navigationTitle("編集")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .sheet(isPresented: $showShareSheet) {
            if let shareImage {
                ShareSheet(items: [shareImage])
            }
        }
        .alert("保存しました", isPresented: Binding(
            get: { saveMessage != nil },
            set: { if !$0 { saveMessage = nil } }
        )) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(saveMessage ?? "")
        }
    }

    private var editForm: some View {
        NeonCard {
            VStack(alignment: .leading, spacing: 14) {
                Text("会話設定")
                    .font(.headline.weight(.black))

                TextField("相手の名前", text: $work.characterName)
                    .textFieldStyle(.roundedBorder)
                TextField("自分の名前", text: $work.myName)
                    .textFieldStyle(.roundedBorder)

                HStack {
                    Text("相手アイコン")
                    Spacer()
                    TextField("絵文字", text: $work.characterIcon)
                        .multilineTextAlignment(.trailing)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 96)
                }

                Toggle("既読表示", isOn: $work.showsReadStatus)
                Stepper("未読バッジ \(work.unreadBadgeCount)", value: $work.unreadBadgeCount, in: 0...99)
                Stepper("バッテリー \(work.batteryLevel)%", value: $work.batteryLevel, in: 1...100)

                Picker("背景色", selection: $work.backgroundStyle) {
                    ForEach(ChatColorStyle.allCases) { style in
                        Text(style.label).tag(style)
                    }
                }
                Picker("自分の吹き出し", selection: $work.myBubbleStyle) {
                    ForEach(ChatColorStyle.allCases) { style in
                        Text(style.label).tag(style)
                    }
                }
                Picker("相手の吹き出し", selection: $work.theirBubbleStyle) {
                    ForEach(ChatColorStyle.allCases) { style in
                        Text(style.label).tag(style)
                    }
                }
            }
            .foregroundStyle(.white)
        }
    }

    private var messageEditor: some View {
        NeonCard {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("メッセージ")
                        .font(.headline.weight(.black))
                    Spacer()
                    Button {
                        work.messages.append(.init(text: "新しいメッセージ", isMe: false, time: "21:00", isRead: true))
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .font(.title3)
                }

                ForEach($work.messages) { $message in
                    VStack(spacing: 8) {
                        TextField("本文", text: $message.text, axis: .vertical)
                            .lineLimit(1...4)
                            .textFieldStyle(.roundedBorder)

                        HStack {
                            TextField("時刻", text: $message.time)
                                .textFieldStyle(.roundedBorder)
                                .frame(width: 76)

                            Toggle("自分", isOn: $message.isMe)
                                .labelsHidden()
                            Text(message.isMe ? work.myName : work.characterName)
                                .font(.caption.weight(.bold))
                                .lineLimit(1)

                            Toggle("既読", isOn: $message.isRead)
                                .labelsHidden()

                            Spacer()

                            Button(role: .destructive) {
                                remove(message)
                            } label: {
                                Image(systemName: "trash.fill")
                            }
                        }
                    }
                    .padding(10)
                    .background(.white.opacity(0.06), in: RoundedRectangle(cornerRadius: 8))
                }

                HStack {
                    Button {
                        swapSides()
                    } label: {
                        Label("左右入れ替え", systemImage: "arrow.left.arrow.right")
                    }
                    .buttonStyle(.bordered)

                    Button {
                        randomize()
                    } label: {
                        Label("ランダム作成", systemImage: "shuffle")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .foregroundStyle(.white)
        }
    }

    private var actionButtons: some View {
        VStack(spacing: 10) {
            Button {
                saveWorkAndImage()
            } label: {
                Label("保存", systemImage: "square.and.arrow.down.fill")
            }
            .buttonStyle(PrimaryButtonStyle())

            Button {
                share()
            } label: {
                Label("共有", systemImage: "square.and.arrow.up.fill")
            }
            .buttonStyle(PrimaryButtonStyle())
        }
    }

    private func remove(_ message: ChatMessage) {
        guard work.messages.count > 1 else { return }
        work.messages.removeAll { $0.id == message.id }
    }

    private func swapSides() {
        work.messages = work.messages.map {
            var message = $0
            message.isMe.toggle()
            return message
        }
    }

    private func randomize() {
        let newWork = TemplateStore.randomWork()
        work.title = newWork.title
        work.characterName = newWork.characterName
        work.messages = newWork.messages
        work.unreadBadgeCount = newWork.unreadBadgeCount
        work.batteryLevel = newWork.batteryLevel
        work.backgroundStyle = newWork.backgroundStyle
        work.myBubbleStyle = newWork.myBubbleStyle
        work.theirBubbleStyle = newWork.theirBubbleStyle
        work.characterIcon = newWork.characterIcon
    }

    private func saveWorkAndImage() {
        store.save(work)
        if let image = ImageExportService.render(work: work) {
            ImageExportService.saveToPhotos(image)
            saveMessage = "作品を保存し、カメラロールへの保存も開始しました。"
        } else {
            saveMessage = "作品データを保存しました。画像の書き出しは失敗しました。"
        }
    }

    private func share() {
        guard let image = ImageExportService.render(work: work) else { return }
        shareImage = image
        showShareSheet = true
    }
}
