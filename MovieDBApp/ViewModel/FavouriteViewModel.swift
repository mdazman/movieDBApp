//
//  FavouriteViewModel.swift
//  MovieDBApp
//
//  Created by AZMAN MUHAMMAD on 16/6/22.
//

import Foundation
import CoreData

class FavouriteViewModel: ObservableObject {
    @Published var favouriteMovies: [Movie] = [Movie]()
    
    init(){
        retrieveFavourite()
    }
    
    func retrieveFavourite() {
        PersistenceController.shared.retrieveData(type: "favourite") { movieList in
            var temp = [Movie]()
            
            for object in movieList {
                let movie = Movie(id: Int(object.id), title: object.title, releaseDate: object.releaseDate, voteAverage: object.voteAverage, overview: object.overview, posterPath: object.posterPath, backdropPath: object.backdropPath, posterData: object.posterData, backdropData: object.backdropData)
                temp.append(movie)
            }
            
            DispatchQueue.main.async {
                self.favouriteMovies = temp
            }
        }
    }
    
    func check(movie:Movie) -> Bool {
        var isFound = false
        for fav in favouriteMovies {
            if (fav.id == movie.id) {
                isFound = true
                break
            }
        }
        return isFound
    }
    
    func change(isFav:Bool, movie:Movie) {
        isFav ? addFavourite(movie: movie) : deleteFavourite(movie: movie)
    }
    
    func addFavourite(movie:Movie){
        PersistenceController.shared.addFavourite(movie: movie) {
            favouriteMovies.append(movie)
        }
    }
    
    func deleteFavourite(movie:Movie){

        
        favouriteMovies.removeAll(where: { $0.id == movie.id ?? 0})
    }
}
