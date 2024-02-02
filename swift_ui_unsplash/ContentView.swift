//
//  ContentView.swift
//  swift_ui_
//
//  Created by SERRE Aurélien on 02/02/2024.
//

import SwiftUI
import Foundation
 
let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

struct ContentView: View {
    @StateObject var feedState = FeedState()
    
    
    func loadImages() async {
        await feedState.fetchHomeFeed()
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                Button(action: {
                                Task {
                                    await loadImages()
                                }
                            }, label: {
                                Text("Load Data")
                            })
                ScrollView(.horizontal){
                HStack {
                   
                        
                        if feedState.topics != nil {
                            ForEach(feedState.topics ?? [], id: \.self.id) { item in
                                VStack{
                                    AsyncImage(url: URL(string: item.cover_photo.urls.regular)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }.frame(width: 100, height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                    Text(item.title)
                                }
                            }
                            
                        } else {
                            ForEach(1...12, id: \.self ) { _ in
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: 100, height: 50)
                                    .foregroundColor(Color.gray.opacity(0.4))
                                
                            }
                        }
                    }
                }
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 8) {
                        if feedState.homeFeed != nil {
                            ForEach(feedState.homeFeed ?? [], id: \.self.id) { item in
                                AsyncImage(url: URL(string: item.urls.small)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }.frame(height: 150)
                                   .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                        } else {
                            ForEach(1...12, id: \.self ) { _ in
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(height:150)
                                    .foregroundColor(Color.gray.opacity(0.4))
                                
                            }
                        }
                       
                    }.redacted(reason: feedState.homeFeed == nil ? .placeholder : [])
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
                .navigationTitle("Feed")
            }
            }
            
    }
}


 
#Preview {
    ContentView()
}
