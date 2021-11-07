//
//  SwiftUIView.swift
//  SymPlace
//
//  Created by Hallie on 11/7/21.
//

import SwiftUI

struct AboutInformationView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    Text("Personal Information")
                        .bold()
                        .font(.system(size: 20))
                    Text("Your information is stored anonymously, and none of it can be tied back to you!")
                    
                    Divider()
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                    
                    Text("Well then why ask for it?")
                        .bold()
                        .font(.system(size: 20))
                    Text("Good question! Right now it does nothing, but eventually it will be used to help determine which locations are best for what types of people; So it helps both you and other users optimize their discoverable locations once a larger mass has been reached")
                    
                    Divider()
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                    
                    Text("What about my location?")
                        .bold()
                        .font(.system(size: 20))
                    Text("Well, we can see it either way. But this helps us know what location you prefer to base your experiences around. You can put whatever you like!")
                }.padding()
            }.navigationTitle("Information")
        }
    }
}
