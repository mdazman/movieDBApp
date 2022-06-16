//
//  FavouriteView.swift
//  MovieDBApp
//
//  Created by AZMAN MUHAMMAD on 16/6/22.
//

import SwiftUI

struct FavouriteView: View {
    @EnvironmentObject var favouriteViewModel: FavouriteViewModel
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    MovieType(typeHeaderName: "Favourite",
                              movieArray: favouriteViewModel.favouriteMovies) {}
                }
            }
            .navigationTitle("MovieDBApp")
        }
        
        
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
    }
}
