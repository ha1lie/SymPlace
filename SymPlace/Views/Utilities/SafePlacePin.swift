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
    
    @Environment(\.colorScheme) var darkMode
    
    let safePlace: SafePlace
    
    @State var showDetail: Bool = false
    
    var body: some View {
        Button {
            self.showDetail.toggle()
        } label: {
            ZStack {
                Image(systemName: "circle.fill")
                    .foregroundColor(self.darkMode == .dark ? .white : .black)
                    .font(.system(size: 35))
                Image(systemName: "pin.fill")
                    .foregroundColor(self.darkMode == .dark ? appPurple : appOrange)
                    .font(.system(size: 20))
            }
        }.buttonStyle(PlainButtonStyle()).sheet(isPresented: self.$showDetail) {
            self.showDetail = false
        } content: {
            SafePlaceView(safePlace: self.safePlace)
        }

    }
}
