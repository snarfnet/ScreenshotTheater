import SwiftUI

struct SavedWorksView: View {
    @EnvironmentObject private var store: WorkStore

    var body: some View {
        ZStack {
            AppBackground()

            if store.works.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "tray")
                        .font(.largeTitle)
                    Text("保存した作品はまだありません")
                        .font(.headline.weight(.black))
                    Text("編集画面で保存すると、ここに並びます。")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.65))
                }
                .foregroundStyle(.white)
            } else {
                List {
                    ForEach(store.works) { work in
                        NavigationLink {
                            EditorView(work: work, startsWithAd: false)
                        } label: {
                            HStack(spacing: 12) {
                                Text(work.characterIcon)
                                    .font(.title)
                                    .frame(width: 46, height: 46)
                                    .background(.white.opacity(0.10), in: Circle())

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(work.title)
                                        .font(.headline.weight(.black))
                                    Text("\(work.characterName) / \(work.messages.count)件")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    Text(work.createdAt, style: .date)
                                        .font(.caption2)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .padding(.vertical, 6)
                        }
                    }
                    .onDelete(perform: store.delete)
                }
                .scrollContentBackground(.hidden)
            }
        }
        .navigationTitle("保存した作品")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}
