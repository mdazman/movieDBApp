//
//  MainMovieView.swift
//  MovieDBApp
//
//  Created by AZMAN MUHAMMAD on 14/6/22.
//

import SwiftUI

struct MainMovieView: View {
    @ObservedObject var movieViewModel = MovieViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    MovieType(typeHeaderName: "Popular Movies",
                              movieArray: movieViewModel.popularMovies) {
                        movieViewModel.getPopular()
                    }
                }
                Section {
                    MovieType(typeHeaderName: "Upcoming Movies",
                              movieArray: movieViewModel.upcomingMovies) {
                        movieViewModel.getUpcoming()
                    }
                }
            }
            .navigationTitle("MovieDBApp")
        }
    }
}

struct MainMovieView_Previews: PreviewProvider {
    static var previews: some View {
        MainMovieView()
    }
}
