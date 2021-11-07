//
//  MainScreen.swift
//  SymPlace
//
//  Created by Hallie on 11/6/21.
//

import SwiftUI
import MapKit
import CoreLocation

struct MainScreen: View {
    
    @ObservedObject var locationManager: LocationManager = .shared
    
    @ObservedObject var informationManager: InformationManager = .shared
    
    @State var showProfilePage: Bool = false
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: self.$locationManager.region, showsUserLocation: true, annotationItems: self.locationManager.viewableLocations) { safePlace in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(safePlace.latitude), longitude: CLLocationDegrees(safePlace.longitude)), anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                    SafePlacePin(safePlace: safePlace)
                }
            }
                .ignoresSafeArea()
            VStack {
                HStack {
                    if locationManager.isLoading {
                        Loader()
                            .padding()
                    }
                    Spacer()
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 20)
//                            .frame(width: 40, height: 40)
//                            .foregroundColor(appOrange)
//                    }.onTapGesture {
//                        self.showProfilePage.toggle()
//                    }.padding()
                    
                }
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        print("MAKE A REVIEW OF THE CURRENT LOCATION")
                        informationManager.presentReviewForCoords(lat: (locationManager.userLocation?.coordinate.latitude)!, long: (locationManager.userLocation?.coordinate.longitude)!, isUpdate: false)
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(appLightGreen)
                            Text("Review Here")
                                .foregroundColor(.white)
                                .bold()
                                .padding()
                        }.frame(width: 150, height: 50)
                    }.buttonStyle(PlainButtonStyle())
                        .padding()
                }
            }

        }

    }
}
