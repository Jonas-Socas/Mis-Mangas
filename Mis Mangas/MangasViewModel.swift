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
    
    var mangas: [Manga] = []
    
    var showAlert = false
    var errorMsg = ""
    
    init(interactor: DataInteractor = Network.shared) {
        self.interactor = interactor
    }
    
    func getData(page: Int, limit: Int) async {
        do {
            let mangas = try await interactor.fetchMangas(page: page, limit: limit).items
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
}
