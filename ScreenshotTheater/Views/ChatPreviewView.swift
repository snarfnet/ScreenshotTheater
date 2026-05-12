import SwiftUI

struct ChatPreviewView: View {
    let work: ChatWork
    var exportMode = false

    var body: some View {
        VStack(spacing: 0) {
            fakeStatusBar
            header

            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {
                    ForEach(work.messages) { message in
                        MessageBubble(message: message, work: work)
                    }
                    Spacer(minLength: 12)
                }
                .padding(.horizontal, 14)
                .padding(.top, 18)
            }

            watermark
        }
        .background(
            ZStack {
                work.backgroundStyle.color
                LinearGradient(colors: [.white.opacity(0.08), .clear, .pink.opacity(0.12)], startPoint: .top, endPoint: .bottom)
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: exportMode ? 0 : 24))
    }

    private var fakeStatusBar: some View {
        HStack {
            Text(currentStatusTime)
                .font(.caption.weight(.bold))
            Spacer()
            Image(systemName: "antenna.radiowaves.left.and.right")
            Image(systemName: "wifi")
            HStack(spacing: 3) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(.white.opacity(0.22))
                    .frame(width: 24, height: 11)
                    .overlay(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(work.batteryLevel < 20 ? .red : .white)
                            .frame(width: max(3, CGFloat(work.batteryLevel) / 100 * 22), height: 9)
                            .padding(.leading, 1)
                    }
                Text("\(work.batteryLevel)%")
                    .font(.caption2.weight(.black))
            }
        }
        .font(.caption2.weight(.bold))
        .foregroundStyle(.white)
        .padding(.horizontal, 18)
        .padding(.top, exportMode ? 14 : 10)
        .padding(.bottom, 8)
    }

    private var header: some View {
        HStack(spacing: 10) {
            ZStack(alignment: .topTrailing) {
                Text(work.characterIcon)
                    .font(.title2)
                    .frame(width: 42, height: 42)
                    .background(.white.opacity(0.12), in: Circle())
                if work.unreadBadgeCount > 0 {
                    Text("\(min(work.unreadBadgeCount, 99))")
                        .font(.caption2.weight(.black))
                        .foregroundStyle(.white)
                        .padding(5)
                        .background(.pink, in: Circle())
                        .offset(x: 6, y: -4)
                }
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(work.characterName)
                    .font(.headline.weight(.black))
                Text("架空チャット / joke preview")
                    .font(.caption2.weight(.bold))
                    .foregroundStyle(.white.opacity(0.58))
            }

            Spacer()

            Image(systemName: "sparkles")
                .foregroundStyle(.cyan)
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 14)
        .padding(.vertical, 11)
        .background(.black.opacity(0.24))
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(.white.opacity(0.12))
                .frame(height: 1)
        }
    }

    private var watermark: some View {
        Text("Made with スクショ劇場")
            .font(.caption2.weight(.bold))
            .foregroundStyle(.white.opacity(0.45))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(.black.opacity(0.16))
    }

    private var currentStatusTime: String {
        work.messages.last?.time ?? "21:00"
    }
}

private struct MessageBubble: View {
    let message: ChatMessage
    let work: ChatWork

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if message.isMe { Spacer(minLength: 42) }

            if !message.isMe {
                Text(work.characterIcon)
                    .font(.callout)
                    .frame(width: 30, height: 30)
                    .background(.white.opacity(0.14), in: Circle())
            }

            VStack(alignment: message.isMe ? .trailing : .leading, spacing: 4) {
                Text(message.text)
                    .font(.system(size: 15, weight: .bold))
                    .lineSpacing(3)
                    .foregroundStyle(bubbleStyle.foreground)
                    .padding(.horizontal, 13)
                    .padding(.vertical, 10)
                    .background(bubbleStyle.color, in: RoundedRectangle(cornerRadius: 17))
                    .overlay(
                        RoundedRectangle(cornerRadius: 17)
                            .stroke(.white.opacity(message.isMe ? 0.20 : 0.12))
                    )

                HStack(spacing: 5) {
                    if message.isMe && work.showsReadStatus && message.isRead {
                        Text("既読")
                    }
                    Text(message.time)
                }
                .font(.caption2.weight(.bold))
                .foregroundStyle(.white.opacity(0.55))
            }

            if !message.isMe { Spacer(minLength: 42) }
        }
    }

    private var bubbleStyle: ChatColorStyle {
        message.isMe ? work.myBubbleStyle : work.theirBubbleStyle
    }
}
