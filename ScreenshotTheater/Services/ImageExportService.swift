import SwiftUI
import UIKit
import PhotosUI

@MainActor
enum ImageExportService {
    static func render(work: ChatWork) -> UIImage? {
        let content = ChatPreviewView(work: work, exportMode: true)
            .frame(width: 390, height: 844)

        let renderer = ImageRenderer(content: content)
        renderer.scale = 3
        return renderer.uiImage
    }

    static func saveToPhotos(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
