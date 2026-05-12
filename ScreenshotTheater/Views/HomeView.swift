import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var store: WorkStore

    var body: some View {
        NavigationStack {
            ZStack {
                AppBackground()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 18) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("スクショ劇場")
                                .font(.system(size: 44, weight: .black))
                                .foregroundStyle(
                                    LinearGradient(colors: [.white, .pink, .cyan], startPoint: .leading, endPoint: .trailing)
                                )
                            Text("ありえない会話、作れます。")
                                .font(.title3.weight(.bold))
                                .foregroundStyle(.white.opacity(0.82))
                        }
                        .padding(.top, 28)

                        NeonCard {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("1分でネタ会話スクショ")
                                    .font(.title2.weight(.black))
                                Text("架空チャット画像を作って、保存して、友達に見せる。実在アプリの名前やロゴは使いません。")
                                    .font(.subheadline)
                                    .foregroundStyle(.white.opacity(0.72))
                            }
                        }

                        NavigationLink {
                            TemplateListView()
                        } label: {
                            Label("テンプレから作る", systemImage: "square.grid.2x2.fill")
                        }
                        .buttonStyle(PrimaryButtonStyle())

                        NavigationLink {
                            EditorView(work: TemplateStore.randomWork(), startsWithAd: false)
                        } label: {
                            Label("ランダムで作る", systemImage: "shuffle")
                        }
                        .buttonStyle(PrimaryButtonStyle())

                        NavigationLink {
                            SavedWorksView()
                        } label: {
                            HStack {
                                Label("保存した作品", systemImage: "tray.full.fill")
                                Spacer()
                                Text("\(store.works.count)")
                                    .font(.headline.weight(.black))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 4)
                                    .background(.white.opacity(0.14), in: Capsule())
                            }
                        }
                        .buttonStyle(PrimaryButtonStyle())
                    }
                    .foregroundStyle(.white)
                    .padding(20)
                }
            }
            .navigationBarHidden(true)
        }
    }
}
