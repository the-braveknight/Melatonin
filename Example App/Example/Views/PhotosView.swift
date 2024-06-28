//
//  PhotosView.swift
//  Example
//
//  Created by Zaid Rahhawi on 25/06/2024.
//

import SwiftUI

struct PhotosView: View {
    @State private var photos: [Photo] = []
    
    @Environment(\.service) private var service: Service
    
    var body: some View {
        List {
            ForEach(photos) { photo in
                HStack {
                    AsyncImage(url: photo.image) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(.circle)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 50, height: 50)
                    
                    Text(photo.description)
                }
                
            }
        }
        .navigationTitle("Photos")
        .task(loadPhotos)
    }
    
    @Sendable
    private func loadPhotos() async {
        do {
            self.photos = try await service.load(.photos(page: 1, recordsPerPage: 1))
        } catch {
            print(error)
        }
    }
}

#Preview {
    NavigationStack {
        PhotosView()
    }
}
