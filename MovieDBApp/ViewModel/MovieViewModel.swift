//
//  MovieViewModel.swift
//  MovieDBApp
//
//  Created by AZMAN MUHAMMAD on 15/6/22.
//

import Foundation
import CoreData

class MovieViewModel: ObservableObject {
    
    @Published var popularMovies: [Movie] = [Movie]()
    @Published var upcomingMovies: [Movie] = [Movie]()
    
    private var isSavePopularOnce = true
    private var isSaveUpcomingOnce = true
    
    init() {
        getPopular()
        getUpcoming()
    }
    
    func getPopular()
    {
        APIManager.shared.getPopularMovies { result in
            switch result {
                case .success(let movieResponse):
                DispatchQueue.main.async {
                    let movies = movieResponse.results ?? [Movie]()
                    for movie in movies {
                        //Only insert unique id
                        if self.popularMovies.firstIndex(where: { $0.id == movie.id}) == nil {
                            self.popularMovies.append(movie)
                        }
                    }
                    //Save only the first pull
                    if self.isSavePopularOnce {
                        self.isSavePopularOnce = false
                        self.saveLocalData(isPopular: true)
                    }
                }
                    break
                case .failure(let error): //Check for local data later
                print("error: \(error)")
                self.getLocalData(type: "popular")
                    break
            }
        }
    }
    
    func getUpcoming()
    {
        APIManager.shared.getUpcomingMovies { result in
            switch result {
                case .success(let movieResponse):
                DispatchQueue.main.async {
                    let movies = movieResponse.results ?? [Movie]()
                    for movie in movies {
                        //Only insert unique id
                        if self.upcomingMovies.firstIndex(where: { $0.id == movie.id}) == nil {
                            self.upcomingMovies.append(movie)
                        }
                    }
                }
                    break
                case .failure(let error): //Check for local data later
                print("error: \(error)")
                self.getLocalData(type: "upcoming")
                    break
            }
        }
    }
    
    //CoreData
    func getLocalData(type:String)
    {
        PersistenceController.shared.retrieveData(type: type) { movieList in
            var temp = [Movie]()
            
            for object in movieList {
                let movie = Movie(id: Int(object.id), title: object.title, releaseDate: object.releaseDate, voteAverage: object.voteAverage, overview: object.overview, posterPath: object.posterPath, backdropPath: object.backdropPath, posterData: object.posterData, backdropData: object.backdropData)
                temp.append(movie)
            }
            
            DispatchQueue.main.async {
                if (type=="popular") {
                    self.popularMovies = temp
                }else {
                    self.upcomingMovies = temp
                }
            }
        }
    }
    
    func saveLocalData(isPopular:Bool)
    {
        var type = "popular"
        var movieArray = self.popularMovies
        
        if !isPopular
        {
            type = "upcoming"
            movieArray = self.upcomingMovies
        }
        
        //Delete
//        PersistenceController.shared.deleteData(popular: isPopular)
        
        //Save
        var dataSaveArray = [Movie]()
        
        for movie in movieArray {
            dataSaveArray.append(movie)
        }
        
        PersistenceController.shared.saveData(dataSaveArray, type: type)
        
        savePosterImage(movieArray, type: type)
    }
    
    func savePosterImage(_ movieArray:[Movie], type:String)
    {
        let group = DispatchGroup()
        var tempArray:[(movie:Movie, data:Data)] = []
        
        for movie in movieArray {
            group.enter()
            APIManager.shared.downloadImageData(from: movie.getFullPosterPath()) { data, response, error in
                guard let data = data, error == nil else { return }

                let item = (movie:movie, data:data)
                tempArray.append(item)
                group.leave()
            }
        }
        
        group.notify(queue: .global()) {
            PersistenceController.shared.saveImage(movieArray: tempArray, type: type, imageType: "posterData")
            self.saveBackdropImage(movieArray, type: type)
        }
        
        
    }
    
    func saveBackdropImage(_ movieArray:[Movie], type:String)
    {
        let group = DispatchGroup()
        var tempArray:[(movie:Movie, data:Data)] = []
        
        for movie in movieArray {
            group.enter()
            APIManager.shared.downloadImageData(from: movie.getFullBackdropPath()) { data, response, error in
                guard let data = data, error == nil else { return }

                let item = (movie:movie, data:data)
                tempArray.append(item)
                group.leave()
            }
        }
        
        group.notify(queue: .global()) {
            PersistenceController.shared.saveImage(movieArray: tempArray, type: type, imageType: "backdropData")
            
            //Save only the first pull
            if self.isSaveUpcomingOnce {
                self.isSaveUpcomingOnce = false
                self.saveLocalData(isPopular: false)
            }
        }
    }
    
}
