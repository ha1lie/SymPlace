//
//  SafePlaceView.swift
//  SymPlace
//
//  Created by Hallie on 11/6/21.
//

import SwiftUI
import MapKit

struct SafePlaceView: View {
    
    @Environment(\.colorScheme) var darkMode
    @Environment(\.presentationMode) var presentationMode
    
    let safePlace: SafePlace
    
    let dismiss: () -> Void
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    
                    Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: CLLocationDegrees(self.safePlace.latitude), longitude: CLLocationDegrees(self.safePlace.longitude)), span: MKCoordinateSpan(latitudeDelta: CLLocationDegrees(0.002), longitudeDelta: CLLocationDegrees(0.002)))), interactionModes: [])
                        .frame(height: 200)
                        .cornerRadius(12)
    //                    .padding(.vertical)
                    
                    VStack(alignment: .leading) {
                        Text(safePlace.name ?? "Place Name")
                            .bold()
                        Text(safePlace.addressLine ?? "Address Line")
                        Text("PLACE, ME 04038")
                        
                        Button {
                            UIApplication.shared.openURL(URL(string: "http://maps.apple.com/?daddr=\(self.safePlace.latitude),\(self.safePlace.longitude)")!)
                        } label: {
                            HStack {
                                Image(systemName: "location.fill")
                                Text("Open in maps")
                            }.foregroundColor(.gray)
                        }.buttonStyle(PlainButtonStyle())
                            .padding(.bottom, 6)

                    }
                    
                    Text("Reviews")
                        .font(.title)
                        .bold()
                    Text("Based off of reviews from \(safePlace.reviewCount ?? 1) \(safePlace.reviewCount == 1 ? "person" : "people")")
                    
                    Divider()
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                    
                    Group {
                        Text("Overall Rating")
                            .font(.system(size: 24))
                            .bold()
                        OutOfFive(rating: .constant((safePlace.visibility! + safePlace.lgbtqPoints! + safePlace.bipocPoints! + safePlace.allieStaff!) / 4))
                        
                        Text("LGBTQ+ Rating")
                            .font(.system(size: 24))
                            .bold()
                        OutOfFive(rating: .constant(safePlace.lgbtqPoints!))
                        
                        Text("BIPOC Rating")
                            .font(.system(size: 24))
                            .bold()
                        OutOfFive(rating: .constant(safePlace.bipocPoints!))
                        
                        Text("Staff Allieship")
                            .font(.system(size: 24))
                            .bold()
                        OutOfFive(rating: .constant(safePlace.allieStaff!))
                        
                        Text("Visibility")
                            .font(.system(size: 24))
                            .bold()
                        OutOfFive(rating: .constant(safePlace.allieStaff!))
                    }
                    
                    Button {
                        self.dismiss()
                    } label: {
                        Text("Been here? Add a review")
                            .foregroundColor(appLightGreen)
                    }

                    
                }.padding()
                    .navigationTitle(self.safePlace.name ?? "Name")
            }
        }
    }
}
