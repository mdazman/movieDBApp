//
//  MovieType.swift
//  MovieDBApp
//
//  Created by AZMAN MUHAMMAD on 14/6/22.
//

import SwiftUI

struct MovieType: View {
    var typeHeaderName: String
    var movieArray: [Movie]
    
    //Image dimension
    let width = 200.0
    let height = 300.0
    let titleHeight = 100.0
    
    let hSpace = 15.0
    
    var body: some View {
        List {
            Text(typeHeaderName)
                .font(.largeTitle)
            
            ScrollView(.horizontal){
                HStack (spacing:hSpace) {
                    ForEach(movieArray){ movie in
                        NavigationLink(destination: MovieInfoView(movie: movie)) {
                            MovieItem(movie: movie)
                        }
                    }
                }
            }
            .frame(height:height+titleHeight)
            .listRowSeparator(.hidden)
        }
    }
}

struct MovieType_Previews: PreviewProvider {
    static var previews: some View {
        MovieType(typeHeaderName: "Popular Movies",
        movieArray: [Movie(id: 0, title: "Title", releaseDate: "", voteAverage: 0, overview: "", posterPath: "https://image.tmdb.org/t/p/w200/jrgifaYeUtTnaH7NF5Drkgjg2MB.jpg", backdropPath: ""), Movie(id: 0, title: "Title", releaseDate: "", voteAverage: 0, overview: "", posterPath: "https://image.tmdb.org/t/p/w200/jrgifaYeUtTnaH7NF5Drkgjg2MB.jpg", backdropPath: "")])
    }
}
