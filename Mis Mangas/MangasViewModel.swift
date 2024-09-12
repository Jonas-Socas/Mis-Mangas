//
//  MangasViewModel.swift
//  Mis Mangas
//
//  Created by Jonás Socas on 5/9/24.
//

import Foundation

@Observable
final class MangasViewModel {
    let interactor: DataInteractor
    
    var mangas: [Manga] = [] {
        didSet {
            mangas.forEach { manga in
                print(manga.title)
            }
        }
    }
    
    var showAlert = false
    var isLoading = false
    var errorMsg: String = ""
    
    init(interactor: DataInteractor = Network.shared) {
        self.interactor = interactor
    }
    
    func getData(page: Int, limit: Int) async {
        do {
            let mangas = try await interactor.fetchPaginatedMangas(url: URL.getMangas, page: page, limit: limit).items
            await MainActor.run {
                self.mangas += mangas
            }
        } catch {
            await MainActor.run {
                self.errorMsg = "\(error)"
                self.showAlert.toggle()
            }
        }
    }
    
    func searchManga(query: String, searchType: SearchType, page: Int = 1, limit: Int = 10) async {
        do {
            let mangas = try await interactor.searchMangas(query: query, searchType: searchType, page: page, limit: limit)
            await MainActor.run {
                self.mangas = mangas
            }
        } catch {
            await MainActor.run {
                self.errorMsg = "\(error)"
                self.showAlert.toggle()
            }
        }
    }
    
    func reset() {
        mangas = []
        isLoading = false
        errorMsg = ""
    }
}

enum SearchType: String, CaseIterable, Identifiable {
    case beginsWith
    case contains
    
    var id: String { rawValue }
}
