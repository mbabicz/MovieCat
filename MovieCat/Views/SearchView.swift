//
//  SearchView.swift
//  ShoppingApp
//
//  Created by kz on 14/11/2022.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var movieSearchState = MovieSearchState()
    @EnvironmentObject var user: UserViewModel
    
    
    var body: some View {
        NavigationView {
            VStack{


                LoadingView(isLoading: self.movieSearchState.isLoading, error: self.movieSearchState.error) {
                    self.movieSearchState.search(query: self.movieSearchState.query)
                }
                if self.movieSearchState.movies != nil {
                    List(self.movieSearchState.movies!) { movie in

                        MovieCell(movieID: movie.id)

                    }
                }
//                else {
//                    if user.latestSearchedIDs.isEmpty != true {
//                        VStack{
//                            HStack{
//                                Text("Recently Searched")
//                                    .padding(.leading)
//                                Spacer()
//                                Button {
//                                    user.clearLatestSearched()
//                                } label: {
//                                    HStack{
//                                        Image(systemName: "xmark.circle")
//                                        Text("Clear")
//                                            .padding(.trailing)
//
//                                    }
//                                }
//
//                            }
//                            List(user.latestSearchedIDs, id: \.self) { id in
//                                MovieCell(movieID: Int(id)!)
//                                    .frame(height: 100)
//
//                            }
//                        }
//                    }
//                }

                Spacer()
            }
            .navigationBarTitle("Search")
            .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)


        }

        .listStyle(.sidebar)
        .scrollContentBackground(.hidden)
        .onAppear {
            self.movieSearchState.startObserve()
        }
        .searchable(text: self.$movieSearchState.query)
    }
}

struct SearchBar: View {
    
    @State private var isEditing = false
    @Binding var text: String
    @ObservedObject var movieSearchState = MovieSearchState()

        
    var body: some View{
        HStack{
            TextField("Search...", text: $text, onCommit: {
                print("Oncommit")
                //movieSearchState.search(query: text)
            })
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
                 .onTapGesture {
                    self.isEditing = true
                }
                .overlay(
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)
                        
                        if isEditing {
                            Button {
                                text = ""
                            } label: {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 18)
                                
                            }

                            

                        }
                    }
                )
            if isEditing {
                Button {
                    self.isEditing = false
                    text = ""
                } label: {
                        Text("Cancel")
                }
                .padding(.trailing, 18)
//                .transition(.move(edge: .trailing))
//                .animation(.default, value: 10)

            }
        }
    }
}

struct MovieImage: View{

    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL

    var body: some View{
        ZStack{
            if let image = imageLoader.image{
                Image(uiImage: image).resizable()
            }
        }
        .frame(width: 50, height: 75)
        .aspectRatio(contentMode: .fit)
        .onAppear{
            imageLoader.loadImage(with: imageURL)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    
    static let myEnvObject = UserViewModel()

    static var previews: some View {
        SearchView()
            .environmentObject(myEnvObject)
    }
}
