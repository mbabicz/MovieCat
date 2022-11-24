//
//  LoadingView.swift
//  MovieCat
//
//  Created by kz on 24/11/2022.
//

import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        VStack(alignment: .center){
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .black)).frame(alignment: .center).scaleEffect(3).padding()
            
            Text("Loading").font(.system(size: 25)).padding()
        }

    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

