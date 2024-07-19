//
//  PhotoStreamView.swift
//  Komoot Assignment
//
//  Created by Meißner, Johannes on 19.07.24.
//

import SwiftUI

struct PhotoStreamView: View {
    var photoStream: [String]

    var body: some View {
        ForEach(photoStream, id: \.self) { imageUrl in
            AsyncImage(url: URL(string: imageUrl)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .clipped()
                        .transition(.move(edge: .top))
                } else if phase.error != nil {
                    Color.red
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .transition(.move(edge: .top))
                        .overlay {
                            Text("Something went wrong while loading the image or no image was available.")
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        }
                } else {
                    ProgressView("Loading")
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                }
            }
        }
    }
}
