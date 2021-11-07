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
            self.safePlaceToReview = safePlace
            self.latitude = nil
            self.longitude = nil
            self.isUpdate = upd
            DispatchQueue.main.asyncAfter(deadline: .now() + (upd ? 0 : 1)) {
                self.presentReviewSheet = true
            }
        }
    }
    
    func presentReviewForCoords(lat: Double, long: Double, isUpdate upd: Bool) {
        DispatchQueue.main.async {
            self.latitude = lat
            self.isUpdate = upd
            self.longitude = long
            self.safePlaceToReview = nil
            self.presentReviewSheet = true
        }
    }
}
