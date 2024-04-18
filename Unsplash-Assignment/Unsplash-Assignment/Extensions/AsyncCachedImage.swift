//
//  AysncCachedImage.swift
//  Unsplash-Assignment
//
//  Created by Ashwin Kumar on 16/04/24.
//

import SwiftUI

struct AsyncCachedImage<ImageView: View, PlaceholderView: View>: View {
    // Input dependencies
    var url: URL? // URL of the image to download
    @ViewBuilder var content: (Image) -> ImageView // Closure to define content view
    @ViewBuilder var placeholder: () -> PlaceholderView // Closure to define placeholder view
    
    // Downloaded image
    @State var image: UIImage? = nil // State property to hold the downloaded image
    
    // Initializer
    init(
        url: URL?,
        @ViewBuilder content: @escaping (Image) -> ImageView,
        @ViewBuilder placeholder: @escaping () -> PlaceholderView
    ) {
        self.url = url
        self.content = content
        self.placeholder = placeholder
    }
    
    // Body view
    var body: some View {
        VStack {
            if let uiImage = image {
                // Display content view if image is downloaded
                content(Image(uiImage: uiImage))
            } else {
                // Display placeholder view while image is being downloaded
                placeholder()
                    .onAppear {
                        // Download image asynchronously when placeholder view appears
                        Task {
                            image = await downloadPhoto()
                        }
                    }
            }
        }
    }
    
    // Asynchronous method to download photo
    private func downloadPhoto() async -> UIImage? {
        do {
            // Ensure URL is valid
            guard let url else { return nil }
            
            // Check if image is cached
            if let cachedResponse = URLCache.shared.cachedResponse(for: .init(url: url)) {
                // Return cached image if available
                return UIImage(data: cachedResponse.data)
            } else {
                // Download image if not cached
                let (data, response) = try await URLSession.shared.data(from: url)
                // Store downloaded image data in cache
                URLCache.shared.storeCachedResponse(.init(response: response, data: data), for: .init(url: url))
                
                // Convert downloaded data to UIImage
                guard let image = UIImage(data: data) else {
                    return nil
                }
                
                return image
            }
        } catch {
            // Handle download errors
            print("Error downloading: \(error)")
            return nil
        }
    }
}
