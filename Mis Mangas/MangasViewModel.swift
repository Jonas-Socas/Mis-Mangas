//
//  MangasViewModel.swift
//  Mis Mangas
//
//  Created by Jonás Socas on 5/9/24.
//

import Foundation
import Combine

@Observable
final class MangasViewModel {
    let interactor: DataInteractor
    
    var mangas: [Manga] = []
    var page: Int = 1 {
        didSet {
            if page < 1 {
                page = 1
            }
        }
    }
    var limit: Int = 10
    
    var showAlert = false
    var isLoading = false
    var errorMsg: String = ""
    
    init(interactor: DataInteractor = Network.shared) {
        self.interactor = interactor
    }
    
    func getAllMangas() async {
        do {
            let mangas = try await interactor.fetchPaginatedMangas(url: URL.getMangas, page: page, limit: limit).items
            await MainActor.run {
                self.mangas = mangas
                isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMsg = "\(error)"
                self.showAlert.toggle()
            }
        }
    }
    
    private func getPaginatedMangasWithQuery(query: String, searchMethods: SearchTokenEnum) async {
        do {
            let mangas = try await interactor.fetchPaginatedMangas(query: query, url: searchMethods.url, page: page, limit: limit).items
            await MainActor.run {
                self.mangas = mangas
                isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMsg = "\(error)"
                self.showAlert.toggle()
            }
        }
    }
    
    private func getMangasWithQuery(query: String, searchMethods: SearchTokenEnum) async {
        do {
            let mangas = try await interactor.fetchMangas(query: query, url: searchMethods.url)
            await MainActor.run {
                self.mangas = mangas
                isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMsg = "\(error)"
                self.showAlert.toggle()
            }
        }
    }
    
    func manageSearch(query: String, searchMethod: SearchTokenEnum) async {
        if case .beginWith = searchMethod {
            await getMangasWithQuery(query: query, searchMethods: searchMethod)
        } else {
            await getPaginatedMangasWithQuery(query: query, searchMethods: searchMethod)
        }
    }
    
    func reset() {
        page = 1
        mangas = []
        isLoading = false
        errorMsg = ""
    }
}
