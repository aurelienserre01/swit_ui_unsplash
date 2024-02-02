//
//  FeedState.swift
//  swift_ui_unsplash
//
//  Created by SERRE Aurélien on 02/02/2024.
//

import Foundation
import SwiftUI

struct UnsplashPhoto: Codable {
    let id, slug: String
    let urls: Urls
    let user: User
}

struct Topic: Codable {
    let id, title, status: String
    let cover_photo: UnsplashPhoto

}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb: String
}

// MARK: - User
struct User: Codable {
    let name: String
}

class FeedState: ObservableObject {
    @Published var homeFeed: [UnsplashPhoto]?
    @Published var topics: [Topic]?
    
    func fetchHomeFeed() async {
        do {
            if let url = UnsplashAPI().feedUrl(){
                let request = URLRequest(url: url)
                
                // Faites l'appel réseau
                let (data, _) = try await URLSession.shared.data(for: request)
                
                // Transformez les données en JSON
                let deserializedData = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
                
                // Mettez à jour l'état de la vue
                homeFeed = deserializedData
            }
            
            
        } catch {
            print("Error: \(error)")
        }
        do {
            if let url = UnsplashAPI().topicUrl(){
                let request = URLRequest(url: url)
                
                // Faites l'appel réseau
                let (data, _) = try await URLSession.shared.data(for: request)
                
                // Transformez les données en JSON
                let deserializedData = try JSONDecoder().decode([Topic].self, from: data)
                
                // Mettez à jour l'état de la vue
                topics = deserializedData
            }
            
            
        } catch {
            print("Error: \(error)")
        }
    }
}

