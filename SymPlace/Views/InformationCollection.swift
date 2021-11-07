//
//  InformationCollection.swift
//  SymPlace
//
//  Created by Hallie on 11/6/21.
//

import SwiftUI
import CoreLocation

struct InformationCollectionView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var safePlace: SafePlace? = nil
    @State var latitude: Double? = nil
    @State var longitude: Double? = nil
    
    @State var lgbtqRating: Double = 3.0
    @State var bipocRating: Double = 3.0
    @State var visibilityRating: Double = 3.0
    @State var staffRating: Double = 3.0
    
    @State var showBathroom: Bool = true
    @State var genderNeutralBathroom: Bool = false
    
    @State var loading: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(.vertical, showsIndicators: true) {
                    VStack {
                        Text("Information")
                        Text(self.safePlace?.name ?? "Name")
                        Text(self.safePlace?.addressLine ?? "Address Line")
                        
                        Text("Tell us what you think")
                        Divider()
                            .padding(.horizontal)
                            .padding(.vertical, 6)
                        
                        Group { // LGBTQ Group
                            VStack {
                                HStack {
                                    Text("LGBTQ+ Rating")
                                        .bold()
                                        .font(.title)
                                    
                                    Spacer()
                                    
                                    OutOfFive(rating: self.$lgbtqRating)
                                }
                                Text("Is this place friendly to queer individuals? Did you feel comfortable?")
                                    .foregroundColor(.gray)
                                
                                SymSlider(value: self.$lgbtqRating)
                            }.padding(.vertical)
                            
                            VStack {
                                HStack {
                                    Text("BIPOC Rating")
                                        .bold()
                                        .font(.title)
                                    
                                    Spacer()
                                    
                                    OutOfFive(rating: self.$bipocRating)
                                }
                                Text("Is this place friendly to people of color? Did you feel comfortable?")
                                    .foregroundColor(.gray)
                                
                                SymSlider(value: self.$bipocRating)
                            }.padding(.vertical)
                            
                            VStack {
                                HStack {
                                    Text("Allies Rating")
                                        .bold()
                                        .font(.title)
                                    
                                    Spacer()
                                    
                                    OutOfFive(rating: self.$staffRating)
                                }
                                Text("Would you consider the staff of this establishment to be allies?")
                                    .foregroundColor(.gray)
                                
                                SymSlider(value: self.$staffRating)
                            }.padding(.vertical)
                            
                            VStack {
                                HStack {
                                    Text("Visibility")
                                        .bold()
                                        .font(.title)
                                    
                                    Spacer()
                                    
                                    OutOfFive(rating: self.$visibilityRating)
                                }
                                Text("How would you rate the visibility of the acceptance of others at this establishment?")
                                    .foregroundColor(.gray)
                                
                                SymSlider(value: self.$visibilityRating)
                            }.padding(.vertical)
                        }
                        
                        Group { //Gender neutral bathrooms
                            Divider()
                                .padding(.horizontal)
                                .padding(.vertical, 6)
                            
                            Text("Ameneties")
                                .bold()
                                .font(.title)
                            
                            Text("Available ameneties that might help others at this establishment")
                            
                            if showBathroom {
                                Toggle(isOn: self.$genderNeutralBathroom, label: {Text("Gender Neutral Bathroom")})
                                Button {
                                    withAnimation {
                                        self.showBathroom = false
                                    }
                                } label: {
                                    Text("I am not sure")
                                        .foregroundColor(appLightGreen)
                                }.buttonStyle(PlainButtonStyle())
                            }
                        }
                        
                        Button {
                            if self.safePlace != nil {
                                self.loading = true
                                if InformationManager.shared.isUpdate != nil && InformationManager.shared.isUpdate! {
                                    LocationManager.shared.addReview(toID: self.safePlace!.id, withLGBTQScore: self.lgbtqRating, bipoc: self.bipocRating, visibility: self.visibilityRating, staff: self.staffRating)
                                } else {
                                    //Is a new review
                                    let newReview = SafePlace(name: self.safePlace?.name, atLat: self.safePlace!.latitude, andLong: self.safePlace!.longitude, addressLine: self.safePlace?.addressLine, reviewCount: 1, stateName: self.safePlace?.stateName, townName: self.safePlace?.townName ?? "", zipCode: self.safePlace?.zipCode, lgbtqPoints: self.lgbtqRating, bipocPoints: self.bipocRating, allieStaff: self.staffRating, visibility: self.visibilityRating, genderNeutralBathroom: self.genderNeutralBathroom, id: UUID().uuidString)
                                    
                                    LocationManager.shared.pushReviewToServer(newReview: newReview)
                                }
                                self.loading = false
                                presentationMode.wrappedValue.dismiss()
                            }
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundColor(appBlue)
                                Text("Submit Review")
                                    .bold()
                                    .foregroundColor(self.safePlace != nil ? .white : .white.opacity(0.6))
                                    .padding()
                            }
                        }
                        
                    }.navigationTitle("Leave a Review")
                        .padding()
                }
                if self.loading {
                    Loader()
                }
            }
        }.onAppear {
            self.safePlace = InformationManager.shared.safePlaceToReview
            self.latitude = InformationManager.shared.latitude
            self.longitude = InformationManager.shared.longitude
            
            if self.safePlace == nil {
                print("MAKING A SAFE PLACE OFF OF LAT?LONG")
                if let _ = self.latitude, let _ = self.longitude {
                    SafePlace.fromCoords(lat: self.latitude!, long: self.longitude!, completion: { place in
                        self.safePlace = place
                    })
                }
            }
        }
    }
}
