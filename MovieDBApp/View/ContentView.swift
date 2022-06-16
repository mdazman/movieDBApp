//
//  ContentView.swift
//  MovieDBApp
//
//  Created by AZMAN MUHAMMAD on 14/6/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    enum TabType {
        case movie
        case favourite
    }
    
    @State private var current: TabType = .movie
 
    var body: some View {
        TabView(selection: $current) {
            MainMovieView()
                .tag(TabType.movie)
                .tabItem {
                    Label("Movies", systemImage: "film")
                }
            
            FavouriteView()
                .tag(TabType.favourite)
                .tabItem {
                    Label("Favourites", systemImage: "star.fill")
                }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
