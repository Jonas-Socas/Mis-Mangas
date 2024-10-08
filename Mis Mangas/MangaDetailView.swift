//
//  MangaDetailView.swift
//  Mis Mangas
//
//  Created by Jonás Socas on 9/9/24.
//

import SwiftUI
import SwiftData

struct MangaDetailView: View {
    @Query var myCollection: [MangaInMyCollection]
    @State private var showAddMangaToMyColectionSheet: Bool = false
    var isUpdate: Bool {
        mangaInMyCollection(mangaID: manga.id) != nil
    }
    let manga: Manga
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Imagen principal del manga
                    AsyncImage(url: manga.mainPicture?.url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 400)
                            .cornerRadius(12)
                    } placeholder: {
                        Rectangle()
                            .foregroundColor(.gray)
                            .frame(height: 400)
                            .cornerRadius(12)
                    }
                    
                    // Título del manga
                    Text(manga.title)
                        .font(.title)
                        .bold()
                        .padding(.horizontal)
                    
                    // Información básica: Autores, Capítulos, Volúmenes
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Authors:")
                            .font(.headline)
                        
                        // Convertir array de autores a String
                        Text(manga.formattedAuthors)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text("Chapters: \(manga.chapters ?? 0)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text("Volumes: \(manga.volumes ?? 0)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text("Status: \(manga.status)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text("Score: \(String(format: "%.2f", manga.score)) / 10")
                            .font(.subheadline)

                        
                        // Mostrar géneros si están disponibles
                        if !manga.genres.isEmpty {
                            Text("Genres: \(manga.formattedGenres)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Fechas de inicio y fin (si existen)
                    VStack(alignment: .leading, spacing: 8) {
                        if let startDate = try? Date(manga.startDate ?? "#N/A", strategy: .iso8601) {
                            Text("Start Date: \(startDate.formatted(date: .long, time: .omitted))")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        if let endDate = try? Date(manga.endDate ?? "", strategy: .iso8601) {
                            Text("End Date: \(endDate.formatted(date: .long, time: .omitted))")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Sinopsis del manga
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Synopsis")
                            .font(.headline)
                            .padding(.top)
                        
                        Text(manga.sypnosis ?? "#N/A")
                            .font(.body)
                            .foregroundColor(.primary)
                            .padding(.bottom)
                    }
                    .padding(.horizontal)
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            Button {
                showAddMangaToMyColectionSheet.toggle()
            } label: {
                Image(systemName: isUpdate ? "square.and.pencil.circle.fill" : "plus")
                    .font(.system(size: 24))
                    .frame(width: 50, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(radius: 5)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding()

        }
        .sheet(isPresented: $showAddMangaToMyColectionSheet) {
            AddMangaToMyCollection(mangaInMyCollection: mangaInMyCollection(mangaID: manga.id), manga: manga)
                .presentationDetents([.fraction(0.6)])
                .presentationDragIndicator(.visible)
        }
    }
    
    // Helper para formatear las fechas
    func formattedDate(_ date: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        if let parsedDate = inputFormatter.date(from: date) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateStyle = .medium
            return outputFormatter.string(from: parsedDate)
        }
        
        return date // Devuelve la fecha sin formato si no se puede formatear
    }
    
    private func mangaInMyCollection(mangaID: Int) -> MangaInMyCollection? {
        myCollection.first { $0.mangaID == mangaID }
    }
}


#Preview {
    MangaDetailView(manga: Manga.preview)
}
