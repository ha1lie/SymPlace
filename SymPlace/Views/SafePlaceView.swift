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
                            print("LINK TO THE MAPS APP TO GET DIRECTIONS???")
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
                        OutOfFive(rating: .constant(3.0))
                        
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
                    }
                    
                    Button {
                        print("ADD A NEW REVIEW HERE")
                        print("RUNNING AFTER DISMISS")
                        presentationMode.wrappedValue.dismiss()
                        InformationManager.shared.presentReviewForPlace(self.safePlace, isUpdate: false)
                        
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
