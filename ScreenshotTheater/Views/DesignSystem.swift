import SwiftUI

struct AppBackground: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            LinearGradient(
                colors: [
                    Color(red: 0.12, green: 0.0, blue: 0.16).opacity(0.9),
                    Color.black,
                    Color(red: 0.0, green: 0.10, blue: 0.16).opacity(0.85)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        }
    }
}

struct NeonCard<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(16)
            .background(Color.white.opacity(0.07), in: RoundedRectangle(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(
                        LinearGradient(colors: [.pink, .cyan.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing),
                        lineWidth: 1
                    )
            )
            .shadow(color: .pink.opacity(0.25), radius: 12)
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline.weight(.black))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                LinearGradient(colors: [.pink, .cyan], startPoint: .leading, endPoint: .trailing),
                in: RoundedRectangle(cornerRadius: 8)
            )
            .foregroundStyle(.black)
            .opacity(configuration.isPressed ? 0.75 : 1)
    }
}

struct AdPlaceholderView: View {
    let label: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "rectangle.badge.plus")
            Text(label)
            Spacer()
            Text("AD")
                .font(.caption2.weight(.black))
                .padding(.horizontal, 7)
                .padding(.vertical, 3)
                .background(.yellow, in: Capsule())
                .foregroundStyle(.black)
        }
        .font(.caption.weight(.bold))
        .foregroundStyle(.white.opacity(0.8))
        .padding(12)
        .background(Color.white.opacity(0.06), in: RoundedRectangle(cornerRadius: 8))
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.white.opacity(0.12)))
    }
}
