//
//  ProfileView.swift
//  SymPlace
//
//  Created by Hallie on 11/6/21.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            
            Button {
                NotificationManager.shared.sendLocalNotification(title: "OPEN TO THE PAGE", body: "I DONT KNOW IF ITS GONNA WORK BUT WERE GONNA TRY", location: Location(lat: -70.0830, long: 40.1849, confidence: 1))
            } label: {
                Text("SEND LOCAL NOTIFICATIONS")
            }
            
            Button {
                
                InformationManager.shared.presentReviewForPlace(SafePlace(name: "Gordon Field House", atLat: 43.08520480732186, andLong: -77.67165035916238, addressLine: "RIT, Field House", reviewCount: 1, stateName: "New York", townName: "Henrietta", zipCode: "16423", lgbtqPoints: 3.2, bipocPoints: 4.0, allieStaff: 3.8, visibility: 2.0, genderNeutralBathroom: true, id: "khbfow"), isUpdate: true)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("SHOW THE REVIEW PAGE")
            }


        }
    }
}
