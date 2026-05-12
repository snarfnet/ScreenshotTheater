import SwiftUI

struct TemplateListView: View {
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ZStack {
            AppBackground()

            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(TemplateStore.templates) { template in
                        NavigationLink {
                            EditorView(work: TemplateStore.work(from: template), startsWithAd: true)
                        } label: {
                            TemplateCard(template: template)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(16)
            }
        }
        .navigationTitle("テンプレ")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

private struct TemplateCard: View {
    let template: ChatTemplate

    var body: some View {
        NeonCard {
            VStack(alignment: .leading, spacing: 10) {
                Text(template.emoji)
                    .font(.largeTitle)
                Text(template.category)
                    .font(.headline.weight(.black))
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
                Text(template.description)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.72))
                    .lineLimit(3)
                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, minHeight: 150, alignment: .topLeading)
            .foregroundStyle(.white)
        }
    }
}
