//
//  MangaDetailView.swift
//  Mis Mangas
//
//  Created by Jonás Socas on 6/9/24.
//

import SwiftUI

struct MangaCellView: View {
    let manga: Manga
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Imagen del manga
            AsyncImage(url: manga.mainPicture?.url) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 150)
                    .cornerRadius(8)
            } placeholder: {
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: 100, height: 150)
                    .cornerRadius(8)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(manga.title)
                    .font(.headline)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .foregroundColor(.primary)
                
                Text(manga.titleJapanese ?? "#N/A")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                // Sinopsis (abreviada)
                Text(manga.sypnosis ?? "#N/A")
                    .font(.caption2)
                    .lineLimit(5)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                
                // Puntuación
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("\(String(format: "%.2f", manga.score))")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
            }
        }
    }
}

#Preview {
    MangaCellView(manga: Manga.preview)
}
