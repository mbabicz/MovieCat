//
//  NotificationsView.swift
//  MovieCat
//
//  Created by Bartosz Rzechółka on 16/01/2023.
//

import SwiftUI

struct NotificationsView: View {
    
    @State var toggleIsActive: Bool = false
    var body: some View {
        VStack(spacing: 10){
            Notifications(text: "Recommendations")
            Notifications(text: "Tips and Tricks")
            Notifications(text: "Featuresd Trailers")
            Notifications(text: "Now in Theaters")
            Notifications(text: "Trending Now")
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}

struct Notifications: View {
    
    var text: String
    
    @State var toggleIsActive: Bool = false
    var body: some View {
        VStack{
            Toggle(
                isOn: $toggleIsActive,
                label: {
                Text(text)
            })
            .toggleStyle(SwitchToggleStyle(tint: Color("Red")))
            .padding()
            .background(
                Color(UIColor.tertiarySystemBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            )
        }
    }
}
