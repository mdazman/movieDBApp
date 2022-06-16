//
//  MovieInfoView.swift
//  MovieDBApp
//
//  Created by AZMAN MUHAMMAD on 14/6/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieInfoView: View {
    let movie: Movie?
    
    let verticalSpace = 10.0
    let leftMargin = 10.0
    
    @State var isFav = false
    
    var body: some View {
        VStack (alignment: .leading, spacing: verticalSpace){
            WebImage(url: URL(string: movie?.getFullBackdropPath() ?? ""))
                .resizable()
                .placeholder {
                    if let data = movie?.backdropData
                    {
                        if let image = UIImage(data: data)
                        {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                    else
                    {
                        if let image = UIImage(named: "default_H.jpg")
                        {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
                .scaledToFit()
            
            Group {
                Text("Title: \(movie?.title ?? "")")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Release Date: \(movie?.releaseDate ?? "")")
                    .font(.title3)
                
                Text("Rating: \(movie?.voteAverage ?? 0, specifier: "%.1f")")
                    .font(.title3)
                
                Text("Summary:")
                    .font(.title3)
                
                ScrollView {
                    VStack {
                        Text(movie?.overview ?? "")
                    }
                    .padding(.trailing, leftMargin)
                }
                
            }
            .padding(.leading, leftMargin)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                isFav.toggle()
//                favVM.toggleFavourites(movie: movie, isSet: isSet)
            } label: {
                Label("Toggle Favorite", systemImage: isFav ? "star.fill" : "star")
            }
        }
    }
}

struct MovieInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MovieInfoView(movie: Movie(id: 0, title: "Harry Potter and the Hunger Games", releaseDate: "01-06-2022", voteAverage: 7.0, overview: "Professor Albus Dumbledore knows the powerful, dark wizard Gellert Grindelwald is moving to seize control of the wizarding world. Unable to stop him alone, he entrusts magizoologist Newt Scamander to lead an intrepid team of wizards and witches. They soon encounter an array of old and new beasts as they clash with Grindelwald's growing legion of followers.", posterPath: "", backdropPath: "https://image.tmdb.org/t/p/w400/zGLHX92Gk96O1DJvLil7ObJTbaL.jpg", posterData: nil, backdropData: nil))
    }
}
