//
//  InformationManager.swift
//  SymPlace
//
//  Created by Hallie on 11/6/21.
//

import Foundation
import SwiftUI
import CoreLocation
import MapKit

class InformationManager: ObservableObject {
    static let shared: InformationManager = InformationManager()
    @Published var presentedPlace: SafePlace? = nil
    
    @Published var presentReviewSheet: Bool = false
    @Published var safePlaceToReview: SafePlace? = nil
    @Published var latitude: Double? = nil
    @Published var longitude: Double? = nil
    @Published var isUpdate: Bool? = nil
    
    func presentReviewForPlace(_ safePlace: SafePlace?, isUpdate upd: Bool) {
        DispatchQueue.main.async {
            self.presentReviewSheet = true
            self.latitude = nil
            self.longitude = nil
            self.isUpdate = upd
            DispatchQueue.main.asyncAfter(deadline: .now() + (upd ? 0 : 10)) {
                print("PRESENTING IT")
                self.safePlaceToReview = safePlace
            }
        }
    }
    
    func presentReviewForCoords(lat: Double, long: Double, isUpdate: Bool) {
        DispatchQueue.main.async {
            print("SETTING IT TO SHOW")
            self.latitude = lat
            self.isUpdate = isUpdate
            self.longitude = long
            self.safePlaceToReview = nil
            self.presentReviewSheet = true
        }
    }
}
