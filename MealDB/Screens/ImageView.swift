//
//  ImageView.swift
//  MealDB
//
//  Created by naga vineel golla on 1/3/24.
//

import SwiftUI

struct ImageView: View {
    let url: String
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        VStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else if let _ = imageLoader.error {
                Image(Constants.NoImage)
                    .resizable()
                    .scaledToFill()
            } else {
                ProgressView(Constants.loading)
            }
        }.task {
            downloadImage()
        }
    }
    
    private func downloadImage() {
        imageLoader.getImage(urlString: url)
    }
}
