//
//  SafePlace.swift
//  SymPlace
//
//  Created by Hallie on 11/6/21.
//

import Foundation
import MapKit
import CoreLocation

class SafePlace: NSObject, Identifiable, Codable {
    static func == (lhs: SafePlace, rhs: SafePlace) -> Bool {
        return lhs.name == rhs.name //TODO: MAKE THIS ACTUALLY COMPARE
    }
    
//    43.08520480732186, -77.67165035916238 -- GORDON FIELD HOUSE
//    43.65375856813569, -70.26381379962461 -- Coffee by design
    // 43.68083926087146, -70.43864127263986 -- Aroma joes coffee, gorham maine
    
    
    
    let longitude: Float
    let latitude: Float
    let name: String?
    let reviewCount: Int?
    let addressLine: String?
    let stateName: String?
    let townName: String?
    let zipCode: String?
    let averageSafety: Double? //Average all the points together
    let lgbtqPoints: Double? // Scale of 1-5
    let bipocPoints: Double? // Scale of 1-5
    let allieStaff: Double? // Scale of 1-5
    let visibility: Double? // Scale of 1-5
    let genderNeutralBathroom: Bool?
    let id: String
    
    static func fromCoords(lat: Double, long: Double, completion: @escaping (SafePlace?) -> Void) {
        let locationURL = URL(string: "https://api.halz.dev/places/info/\(long)/\(lat)")
        
        URLSession.shared.dataTask(with: URLRequest(url: locationURL!)) { data, response, error in
            print("DATA TASK RETURNED")
            guard data != nil else {
                print("NO DATA SAD BOI HOURS")
                return
            }
            if let json = try? JSON(data: data!) {
                completion(SafePlace(name: json["data"]["name"].stringValue, atLat: Float(lat), andLong: Float(long), addressLine: json["data"]["full_address"].string, reviewCount: 0, stateName: json["data"]["state"].string, townName: json["data"]["city"].string ?? "", zipCode: json["data"]["zipcode"].string, lgbtqPoints: 0.0, bipocPoints: 0.0, allieStaff: 0.0, visibility: 0.0, genderNeutralBathroom: false, id: "THISISJOKE"))
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    init(name: String?, atLat latitude: Float, andLong longitude: Float, addressLine: String?, reviewCount: Int?, stateName: String?, townName: String, zipCode: String?, lgbtqPoints: Double?, bipocPoints: Double?, allieStaff: Double?, visibility: Double?, genderNeutralBathroom: Bool?, id: String) {
        self.name = name
        self.longitude = longitude
        self.latitude = latitude
        self.addressLine = addressLine
        self.reviewCount = reviewCount
        self.stateName = stateName
        self.townName = townName
        self.zipCode = zipCode
        self.averageSafety = nil
        self.lgbtqPoints = lgbtqPoints
        self.bipocPoints = bipocPoints
        self.allieStaff = allieStaff
        self.visibility = visibility
        self.genderNeutralBathroom = genderNeutralBathroom
        self.id = id
    }
    
    func jsonVersion() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
