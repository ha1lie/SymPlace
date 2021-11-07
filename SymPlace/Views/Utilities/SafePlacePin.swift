//
//  SafePlacePin.swift
//  SymPlace
//
//  Created by Hallie on 11/6/21.
//

import SwiftUI
import MapKit
import CoreLocation

struct SafePlacePin: View {
    
    let safePlace: SafePlace
    
    @State var showDetail: Bool = false
    
    func fuckOffSheet() {
        self.showDetail = false
        InformationManager.shared.presentReviewForPlace(self.safePlace, isUpdate: true)
    }
    
    var body: some View {
        Button {
            self.showDetail.toggle()
        } label: {
            ZStack {
                Image(systemName: "circle.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 35))
                Image(systemName: "pin.fill")
                    .foregroundColor(appPurple)
                    .font(.system(size: 20))
            }
        }.buttonStyle(PlainButtonStyle()).sheet(isPresented: self.$showDetail) {
            self.showDetail = false
        } content: {
            SafePlaceView(safePlace: self.safePlace) {
                self.fuckOffSheet()
            }
        }

    }
}
