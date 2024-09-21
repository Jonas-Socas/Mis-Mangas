//
//  AddMangaToMyCollection.swift
//  Mis Mangas
//
//  Created by Jonás Socas on 21/9/24.
//

import SwiftUI

struct AddMangaToMyCollection: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var volumesInMyColection: Int = 0
    @State private var currentlyReadingVolumeNumber: Int = 0
    @State private var haveThemAll: Bool = false
    
    @State  var mangaInMyCollection: MangaInMyCollection?
    
    var isUpdate: Bool {
        mangaInMyCollection != nil
    }
    
    let manga: Manga
    
    var body: some View {
        NavigationStack {
            ZStack {
                Form {
                    Section{
                        Text(manga.title)
                            .font(.headline.bold())
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
                    }
                    if let volumes = manga.volumes {
                        Section("Volumes"){
                            Stepper("In my colection: \(volumesInMyColection)", value: $volumesInMyColection, in: (0...volumes))
                            Stepper("Currently reading: \(currentlyReadingVolumeNumber)", value: $currentlyReadingVolumeNumber, in: (0...volumes))
                        }
                    }
                    Section {
                        Toggle(isOn: $haveThemAll) {
                            Text("Have them all...")
                        }
                    }
                    Button {
                        if let mangaInMyCollection {
                            updateManga(mangaInMyCollection)
                        } else {
                            addManga()
                        }
                        dismiss()
                    } label: {
                        Text(isUpdate ? "Update" : "Save")
                            .font(.callout)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                .onAppear {
                    if let mangaInMyCollectionUnwrapped = mangaInMyCollection {
                        mangaInMyCollection = mangaInMyCollectionUnwrapped
                        volumesInMyColection = mangaInMyCollectionUnwrapped.purchasedVolumes
                        currentlyReadingVolumeNumber = mangaInMyCollectionUnwrapped.currentVolumeReading
                        haveThemAll = mangaInMyCollectionUnwrapped.isComplete
                    }
                }
                if isUpdate {
                    Button(role: .destructive) {
                        deleteManga(manga: mangaInMyCollection)
                        dismiss()
                    } label: {
                        Image(systemName: "minus.circle.fill")
                            .font(.system(size: 24))
                            .frame(width: 50, height: 50)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .padding()
                }
            }
        }
    }
    
    private func addManga() {
        let newManga = MangaInMyCollection(mangaID: manga.id, totalVolumes: manga.volumes ?? 0, purchasedVolumes: volumesInMyColection, currentVolumeReading: currentlyReadingVolumeNumber, isComplete: haveThemAll)
        context.insert(newManga)
        saveContext()
    }
    
    private func updateManga(_ mangaInMyColection: MangaInMyCollection) {
        mangaInMyColection.mangaID = manga.id
        mangaInMyColection.totalVolumes = manga.volumes ?? 0
        mangaInMyColection.purchasedVolumes = volumesInMyColection
        mangaInMyColection.currentVolumeReading = currentlyReadingVolumeNumber
        mangaInMyColection.isComplete = haveThemAll
        saveContext()
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error guardando el contexto: \(error)")
        }
    }
    
    private func deleteManga(manga: MangaInMyCollection?) {
        guard let manga else { return }
        context.delete(manga)
        saveContext()
    }
}


#Preview {
    AddMangaToMyCollection(manga: Manga.preview)
}
