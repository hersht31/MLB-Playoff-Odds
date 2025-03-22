import SwiftUI

struct AsyncImage: View {
    @StateObject private var loader: ImageLoader
    let placeholder: Image
    @Environment(\.colorScheme) var colorScheme

    init(url: String?, placeholder: Image = Image(systemName: "photo")) {
        self.placeholder = placeholder
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }

    var body: some View {
        image
            .onAppear(perform: loader.load)
    }

    private var image: some View {
        Group {
            if let uiImage = loader.image {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)  // Maintain aspect ratio
                    .frame(maxWidth: 30, maxHeight: 30)  // Restrict the maximum size
                    .padding(4)  // Add some padding to ensure the image is not clipped
                    .background(colorScheme == .dark ? Color.gray : Color.white)
                    .clipShape(Circle())  // Clip to a circle
            } else {
                placeholder
                    .resizable()
                    .aspectRatio(contentMode: .fit)  // Maintain aspect ratio
                    .frame(maxWidth: 30, maxHeight: 30)  // Restrict the maximum size
                    .padding(4)  // Add some padding to ensure the placeholder is not clipped
                    .background(colorScheme == .dark ? Color.gray : Color.white)
                    .clipShape(Circle())  // Clip to a circle
            }
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: String?

    init(url: String?) {
        self.url = url
    }

    func load() {
        guard let url = url, let imageURL = URL(string: url) else {
            return
        }

        URLSession.shared.dataTask(with: imageURL) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }

            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
