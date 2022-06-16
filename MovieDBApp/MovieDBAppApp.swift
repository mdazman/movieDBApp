//
//  MovieDBAppApp.swift
//  MovieDBApp
//
//  Created by AZMAN MUHAMMAD on 14/6/22.
//

import SwiftUI

@main
struct MovieDBAppApp: App {
    @StateObject var favouriteViewModel = FavouriteViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favouriteViewModel)
        }
    }
}
