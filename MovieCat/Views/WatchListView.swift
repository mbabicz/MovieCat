//
//  FavoritesView.swift
//  MovieCat
//
//  Created by kz on 14/11/2022.
//

import SwiftUI

struct WatchListView: View {
    
    @EnvironmentObject var user: UserViewModel

    var body: some View {
        NavigationView{
            ZStack{
                if(user.watchListIDs.isEmpty != true){
                    VStack{
                        List(user.watchListIDs, id: \.self) { id in
                            MovieCell(movieID: Int(id)!)
                        }
                    }
                }
                else {
                    VStack{
                        Text("Your Watchlist will appear here")
                            .font(.title)
                        Text("Add movie to your Watchlist by clicking \(Image(systemName: "heart.fill"))  in the details view of the movie")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray.opacity(0.75))
                    }
                }
            }
            .navigationTitle("WatchList")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.black, for: .navigationBar)
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {

    static let myEnvObject = UserViewModel()
    static var previews: some View {
        WatchListView()
            .environmentObject(myEnvObject)
    }
}



