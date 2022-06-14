//
//  MovieItem.swift
//  MovieDBApp
//
//  Created by AZMAN MUHAMMAD on 14/6/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieItem: View {
    let movie: Movie
    
    //Image dimension
    let width = 200.0
    let height = 300.0
    let titleHeight = 100.0
    let corner = 15.0
    
    var body: some View {
        VStack {
            WebImage(url: URL(string: movie.posterPath ?? ""))
                .resizable()
                .placeholder {
                    Image(uiImage: UIImage(named: "default.jpeg")!)
                        .resizable()
                        .frame(width: width, height: height)
                    }
                .frame(width:width, height: height)
                .cornerRadius(corner)
            
            Text(movie.title ?? "")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
        }
        .frame(width: width, height: height + titleHeight, alignment: .top)
    }
}

struct MovieItem_Previews: PreviewProvider {
    static var previews: some View {
        MovieItem(movie: Movie(id: 0, title: "Title", releaseDate: "", voteAverage: 0, overview: "", posterPath: "https://image.tmdb.org/t/p/w200/jrgifaYeUtTnaH7NF5Drkgjg2MB.jpg"))
    }
}
