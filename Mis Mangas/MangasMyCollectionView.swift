//
//  MangasMyColecctionView.swift
//  Mis Mangas
//
//  Created by Jonás Socas on 21/9/24.
//

import SwiftUI
import SwiftData

struct MangasMyCollectionView: View {
    @Environment(\.modelContext) private var context
    @Environment(MangasViewModel.self) var vm
    @Query var myCollection: [MangaInMyCollection]
    
    @State var myMangas: [Manga] = []

    var body: some View {
        NavigationStack {
            List {
                ForEach(myMangas, id: \.id) { mangaInCollection in
                    NavigationLink(destination: MangaDetailView(manga: mangaInCollection)) {
                        MangaCellView(manga: mangaInCollection)
                    }
                }
                .navigationTitle("My Collection")
            }
            .overlay {
                if myMangas.isEmpty {
                    ContentUnavailableView(
                        "Nothing in your collection",
                        systemImage: "magazine",
                        description: Text(
                            "Add your mangas in the Mangas List"
                        )
                    )
                }
            }
        }
        .task(id: myCollection) {
            myMangas = await vm.getMangasInMyCollection(collection: myCollection)
        }
    }
}

#Preview {
    MangasMyCollectionView()
}
