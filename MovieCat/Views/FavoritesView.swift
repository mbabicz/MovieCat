//
//  FavoritesView.swift
//  MovieCat
//
//  Created by kz on 14/11/2022.
//

import SwiftUI

struct FavoritesView: View {
    
    @EnvironmentObject var user: UserViewModel

    var body: some View {
        NavigationView{
            if(user.watchListIDs.isEmpty != true){
                VStack{
                    List(user.watchListIDs, id: \.self) { ids in
                        Text(ids)

                    }
                }


            }
            else {
                HStack{
                    Text("fav")
                    Button {
                        user.getUserWatchList()
                    } label: {
                        Text("test")
                    }
                }


            }
        }
//        .onAppear{
//            user.getUserWatchList()
//        }

        
    }

}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
