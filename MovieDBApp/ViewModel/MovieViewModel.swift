//
//  MovieViewModel.swift
//  MovieDBApp
//
//  Created by AZMAN MUHAMMAD on 15/6/22.
//

import Foundation

class MovieViewModel: ObservableObject {
    
    @Published var popularMovies: [Movie] = [Movie]()
    @Published var upcomingMovies: [Movie] = [Movie]()
    
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
                }
                    break
                case .failure(let error): //Check for local data later
                print("error: \(error)")
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
                    break
            }
        }
    }
}
