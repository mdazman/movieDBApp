//
//  MainMovieView.swift
//  MovieDBApp
//
//  Created by AZMAN MUHAMMAD on 14/6/22.
//

import SwiftUI

struct MainMovieView: View {
    var body: some View {
        NavigationView {
            Form {
                Section {
                    MovieType(typeHeaderName: "Popular Movies", movieArray:
                                [Movie(id: 0, title: "Harry Potter and sdsds sdsd sdsd sdsd ", releaseDate: "01-06-2022", voteAverage: 7.0, overview: "Professor Albus Dumbledore knows the powerful, dark wizard Gellert Grindelwald is moving to seize control of the wizarding world. Unable to stop him alone, he entrusts magizoologist Newt Scamander to lead an intrepid team of wizards and witches. They soon encounter an array of old and new beasts as they clash with Grindelwald's growing legion of followers.", posterPath: "https://image.tmdb.org/t/p/w200/jrgifaYeUtTnaH7NF5Drkgjg2MB.jpg", backdropPath: "https://image.tmdb.org/t/p/w400/zGLHX92Gk96O1DJvLil7ObJTbaL.jpg"), Movie(id: 1, title: "Title", releaseDate: "", voteAverage: 0, overview: "", posterPath: "https://image.tmdb.org/t/p/w200/jrgifaYeUtTnaH7NF5Drkgjg2MB.jpg", backdropPath: "")])
                }
                Section {
                    MovieType(typeHeaderName: "Upcoming Movies", movieArray:
                                [Movie(id: 0, title: "Title", releaseDate: "", voteAverage: 0, overview: "", posterPath: "https://image.tmdb.org/t/p/w200/jrgifaYeUtTnaH7NF5Drkgjg2MB.jpg", backdropPath: ""), Movie(id: 1, title: "Title", releaseDate: "", voteAverage: 0, overview: "", posterPath: "https://image.tmdb.org/t/p/w200/jrgifaYeUtTnaH7NF5Drkgjg2MB.jpg", backdropPath: "")])
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
