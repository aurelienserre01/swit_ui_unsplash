//
//  UnsplashAPI.swift
//  swift_ui_unsplash
//
//  Created by SERRE Aurélien on 02/02/2024.
//
import Foundation

struct UnsplashAPI {
    func unsplashApiBaseUrl() -> URLComponents {
        var urlComponents: URLComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.unsplash.com"
        urlComponents.queryItems = [
                URLQueryItem(name: "client_id", value: ConfigurationManager.instance.plistDictionnary.clientId)
            ]
        
        return urlComponents
    }
    
    
    // Par défaut orderBy = "popular" et perPage = 10 -> Lisez la documentation de l'API pour comprendre les paramètres, vous pouvez aussi en ajouter d'autres si vous le souhaitez
    func feedUrl(orderBy: String = "popular", perPage: Int = 10) -> URL? {
        var components = unsplashApiBaseUrl()
        components.path = "/photos"
        components.queryItems?.append( URLQueryItem(name: "order_by", value: orderBy))
        components.queryItems?.append( URLQueryItem(name: "per_page", value: String(perPage)))
        
        return components.url
    }
    
    func topicUrl() -> URL? {
        var components = unsplashApiBaseUrl()
        components.path = "/topics"
        return components.url
    }
    
    
}
