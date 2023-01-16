//
//  AppInfoView.swift
//  MovieCat
//
//  Created by Bartosz Rzechółka on 16/01/2023.
//

import SwiftUI

struct AppInfoView: View {
    var body: some View {
        NavigationView{
            VStack(spacing: 20){
                GroupBox(
                    label:
                        SettingsLabelView(labelText: "MovieCat", labelImage: "info.circle")
                ){
                    Divider().padding(.vertical, 4)
                    
                    HStack(alignment: .center, spacing: 10){
                        Image("Icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .cornerRadius(9)
                           
                    
                    Text("The Application is using TMDB API and Server API to reduce user searching movies resources time with search engine.")
                            .font(.footnote)
                }
                }
                
                GroupBox(
                    label: SettingsLabelView(labelText: "APPLICATION", labelImage: "apps.iphone")
                ) {
                    
                   
                    SettingsRowView(name: "DEVELOPER", content: "Michał Babicz")
                    SettingsRowView(name: "DESIGNER", content: "Bartosz Rzechółka")
                    SettingsRowView(name: "COMPATIBILITY", content: "IOS 15")
                    SettingsRowView(name: "SourceCode", linkLabel: "GitHub", linkDestination: "github.com/mbabicz/MovieCat")
                    SettingsRowView(name: "VERSION", content: "1.0.0")
    
                }
                
                Spacer()
                
            }
            .navigationTitle("App Info")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AppInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AppInfoView()
    }
}

struct SettingsLabelView: View {
    
    var labelText: String
    var labelImage: String
    
    var body: some View {
        HStack {
            Text(labelText.uppercased()).fontWeight(.bold)
            Spacer()
            Image(systemName: labelImage)
        }
    }
}

struct SettingsRowView: View {
    
    var name: String
    var content: String? = nil
    var linkLabel: String? = nil
    var linkDestination: String? = nil
    
    var body: some View {
        VStack {
            
            Divider().padding(.vertical,4)
            
            HStack {
                Text(name).foregroundColor(Color.gray)
                Spacer()
                if content != nil {
                    Text(content!)
                } else if (linkLabel != nil && linkDestination != nil ) {
                    Link(linkLabel!, destination: URL(string: "https://\(linkDestination!)")!)
                    Image(systemName: "arrow.up.right.square").foregroundColor(.pink)
                } else {
                    EmptyView()
                }
                
            }
        }
    }
}
