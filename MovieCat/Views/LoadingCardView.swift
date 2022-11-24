//
//  LoadingCardView.swift
//  MovieCat
//
//  Created by kz on 24/11/2022.
//

import SwiftUI

struct LoadingCardView: View {
    
    let isLoading: Bool
    let error: NSError?
    let retryAction: (() -> ())?
    
    var body: some View {
        Group {
            if isLoading {
                HStack {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black)).frame(alignment: .center).scaleEffect(3).padding()
                    Spacer()
                }
            } else if error != nil {
                HStack {
                    Spacer()
                    VStack(spacing: 4) {
                        Text(error!.localizedDescription).font(.headline)
                        if self.retryAction != nil {
                            Button(action: self.retryAction!) {
                                Text("Retry")
                            }
                            .foregroundColor(Color.blue)
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

struct LoadingCardView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingCardView(isLoading: true, error: nil, retryAction: nil)
    }
}
