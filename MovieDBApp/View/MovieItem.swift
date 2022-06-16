//
//  MovieItem.swift
//  MovieDBApp
//
//  Created by AZMAN MUHAMMAD on 14/6/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieItem: View {
    let movie: Movie?
    
    //Image dimension
    let width = 200.0
    let height = 300.0
    let titleHeight = 100.0
    let corner = 15.0
    
    //Title Resize
    let minScaleFactor =  0.4
    let maxLineNumber = 2
    
    var body: some View {
        VStack {
            
            WebImage(url: URL(string: movie?.getFullPosterPath() ?? ""))
                .resizable()
                .placeholder {
                    if let data = movie?.posterData
                    {
                        if let image = UIImage(data: data)
                        {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: width, height: height)
                        }
                    }
                    else
                    {
                        if let image = UIImage(named: "default.jpeg")
                        {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: width, height: height)
                        }
                    }
                }
                .frame(width:width, height: height)
                .cornerRadius(corner)
            
            Text(movie?.title ?? "")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(minScaleFactor)
                .lineLimit(maxLineNumber)
        }
        .frame(width: width, height: height + titleHeight, alignment: .top)
    }
}

struct MovieItem_Previews: PreviewProvider {
    static var previews: some View {
        MovieItem(movie: Movie(id: 0, title: "Title", releaseDate: "", voteAverage: 0, overview: "", posterPath: "https://image.tmdb.org/t/p/w200/jrgifaYeUtTnaH7NF5Drkgjg2MB.jpg", backdropPath: "", posterData: nil, backdropData: nil))
    }
}
