//
//  APIManager.swift
//  MovieDBApp
//
//  Created by AZMAN MUHAMMAD on 15/6/22.
//

import Foundation

class APIManager
{
    private let API_KEY = "00e6c89818e5207b6f7be33c9961cc27"
    
    static let shared = APIManager()
    private var popularPage = 1
    private var upcomingPage = 1
    
    enum APIerror : Error {
        case failedRequest
        case invalidURL
    }
    
    func getPopularMovies(completionHandler: @escaping (Result<MovieResponse, Error>) -> Void)
    {
        let url = "https://api.themoviedb.org/3/movie/popular?api_key="+API_KEY+"&language=en-US&page="+String(self.popularPage)
        
        guard let encodedString = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else {
            completionHandler(.failure(APIerror.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URL(string: encodedString)!, completionHandler: { (data, response, error) in
            
            //Test Error load
//            completionHandler(.failure(APIerror.failedRequest))
//            return
//
            guard let data = data, error == nil else {
                completionHandler(.failure(APIerror.failedRequest))
                return
            }
            
            var movieResponse: MovieResponse?
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                movieResponse = try decoder.decode(MovieResponse.self, from: data)
            }
            catch {
                print("failed to convert \(error.localizedDescription)")
                completionHandler(.failure(APIerror.failedRequest))
            }
            
            guard let json = movieResponse else {
                return
            }
            
            guard json.results != nil else {
                completionHandler(.failure(APIerror.failedRequest))
                return
            }
            
            if self.popularPage < movieResponse?.totalPages ?? 0 {
                self.popularPage+=1
            }
            
            completionHandler(.success(json))
            
        })
        task.resume()
    }
    
    func getUpcomingMovies(completionHandler: @escaping (Result<MovieResponse, Error>) -> Void)
    {
        let url = "https://api.themoviedb.org/3/movie/upcoming?api_key="+API_KEY+"&language=en-US&page="+String(self.upcomingPage)
        
        guard let encodedString = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else {
            completionHandler(.failure(APIerror.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URL(string: encodedString)!, completionHandler: { (data, response, error) in
            //Test Error load
//            completionHandler(.failure(APIerror.failedRequest))
//            return
            
            guard let data = data, error == nil else {
                completionHandler(.failure(APIerror.failedRequest))
                return
            }
            
            var movieResponse: MovieResponse?
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                movieResponse = try decoder.decode(MovieResponse.self, from: data)
            }
            catch {
                print("failed to convert \(error.localizedDescription)")
                completionHandler(.failure(APIerror.failedRequest))
            }
            
            guard let json = movieResponse else {
                return
            }
            
            guard json.results != nil else {
                completionHandler(.failure(APIerror.failedRequest))
                return
            }
            
            if self.upcomingPage < movieResponse?.totalPages ?? 0 {
                self.upcomingPage+=1
            }
            
            completionHandler(.success(json))
            
        })
        task.resume()
    }
    
    func downloadImageData(from url: String, completion: @escaping (Data?, URLResponse?, Error?) -> ())
    {
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: completion).resume()
    }
}
