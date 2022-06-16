//
//  FavouriteView.swift
//  MovieDBApp
//
//  Created by AZMAN MUHAMMAD on 16/6/22.
//

import SwiftUI

struct FavouriteView: View {
    var body: some View {
//        Text("Favourite Time")
        
        NavigationView {
            Form {
                Section {
                    MovieType(typeHeaderName: "Favourite",
                              movieArray: [Movie(id: 0, title: "Title", releaseDate: "", voteAverage: 0, overview: "", posterPath: "https://image.tmdb.org/t/p/w200/jrgifaYeUtTnaH7NF5Drkgjg2MB.jpg", backdropPath: "", posterData: nil, backdropData: nil)]) {}
                }
            }
            .navigationTitle("MovieDBApp")
        }
        
        
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
    }
}
