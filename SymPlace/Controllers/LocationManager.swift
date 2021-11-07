//
//  LocationManager.swift
//  SymPlace
//
//  Created by Hallie on 11/6/21.
//

import Foundation
import MapKit
import CoreLocation

struct Location: Codable {
    let lat: Double
    let long: Double
    let confidence: Int
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    static let shared: LocationManager = LocationManager()
    
    @Published var isLoading: Bool = false
    
    @Published var enabled: Bool = false
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: CLLocationDegrees(0), longitude: CLLocationDegrees(0)), span: MKCoordinateSpan(latitudeDelta: CLLocationDegrees(0.01), longitudeDelta: CLLocationDegrees(0.01))) {
        didSet {
            self.isLoading = true
            self.updateReviews(forRegion: self.region)
        }
    }
    
    @Published var userLocation: CLLocation? = nil
    
    @Published var viewableLocations: [SafePlace] = []
    
    private var initialPosition: Bool = false
    
    private var manager = CLLocationManager()
    
    public func requestAccess() {
        self.manager.requestAlwaysAuthorization()
    }
    
    private func updateReviews(forRegion reg: MKCoordinateRegion) {
        DispatchQueue(label: "backgroundWaiting").asyncAfter(deadline: .now() + 1) {
            if reg.center.longitude == self.region.center.longitude && reg.center.latitude == self.region.center.latitude && reg.span.longitudeDelta == self.region.span.longitudeDelta && reg.span.latitudeDelta == self.region.span.latitudeDelta {
                
                let startLong = reg.center.longitude - reg.span.longitudeDelta
                let topLong = reg.center.longitude + reg.span.longitudeDelta
                let startLat = reg.center.latitude - reg.span.latitudeDelta
                let topLat = reg.center.latitude + reg.span.latitudeDelta
                
                self.locationsWithinRange(startLong: startLong, endLong: topLong, startLat: startLat, endLat: topLat) { finals in
                    DispatchQueue.main.async {
                        self.viewableLocations = finals
                        self.isLoading = false
                    }
                }
            }
        }
    }
    
    private func locationsWithinRange(startLong: Double, endLong: Double, startLat: Double, endLat: Double, completion: @escaping ([SafePlace]) -> Void) {
        let placesURL = URL(string: "https://api.halz.dev/safe-places/get-in-range/\(startLong)/\(endLong)/\(startLat)/\(endLat)")
        
        URLSession.shared.dataTask(with: URLRequest(url: placesURL!)) { data, response, error in
            guard error == nil else {
                print("ERRORED WHEN GETTING THE LOCATIONS IN RANGE")
                return
            }
            DispatchQueue.main.async {
                self.viewableLocations = []
            }
            if let json = try? JSON(data: data!) {
                var tmpLocs: [SafePlace] = []
                for jPiece in json["data"].array ?? [] {
                    tmpLocs.append(SafePlace(name: jPiece["name"].string, atLat: jPiece["latitude"].floatValue, andLong: jPiece["longitude"].floatValue, addressLine: jPiece["addressLine"].string, reviewCount: jPiece["reviewCount"].int, stateName: jPiece["stateName"].string, townName: jPiece["townName"].string ?? "", zipCode: jPiece["zipCode"].string, lgbtqPoints: jPiece["lgbtqPoints"].doubleValue, bipocPoints: jPiece["bipocPoints"].doubleValue, allieStaff: jPiece["allieStaff"].doubleValue, visibility: jPiece["visibility"].doubleValue, genderNeutralBathroom: jPiece["genderNeutralBathroom"].bool, id: jPiece["id"].stringValue))
                }
                completion(tmpLocs)
            }
        }.resume()
    }
    
    override init() {
        super.init()
        
        manager.delegate = self
        manager.distanceFilter = 2
        manager.allowsBackgroundLocationUpdates = true
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        manager.startMonitoringVisits()
    }
    
    public func pushReviewToServer(newReview: SafePlace) {
        self.viewableLocations.append(newReview)
        let postReviewURL = URL(string: "https://api.halz.dev/safe-places/new-review")
        
        var newReviewReq = URLRequest(url: postReviewURL!)
        newReviewReq.httpMethod = "POST"
        newReviewReq.httpBody = newReview.jsonVersion()
        newReviewReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        newReviewReq.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: newReviewReq) { data, response, error in
            print("URL SESSION RESPONSE")
            guard error == nil else {
                print("COULDNT MAKE NEW REVIEW ON SERVER")
                print("ERROR: \(error.debugDescription)")
                return
            }
            
            guard let _ = data else {
                print("DIDNT RETURN ANY DATA")
                return
            }
        }.resume()
    }
    
    public func addReview(toID id: String, withLGBTQScore lgbtq: Double, bipoc: Double, visibility: Double, staff: Double) {
        //Calls to the api to update it
        //"/safe-places/update-review/:id/:lgbtqPoints/:allieStaff/:bipocPoints/:visibility"
        
        let updateURL = URL(string: "https://api.halz.dev/safe-places/update-review/\(id)/\(lgbtq)/\(staff)/\(bipoc)/\(visibility)")
        print("UPDATING AT \(updateURL?.absoluteString)")
        
//        URLSession.shared.dataTask(with: updateURL!).resume()
        
        URLSession.shared.dataTask(with: URLRequest(url: updateURL!)) { _, _, _ in
            print("UPDATED")
        }.resume()
    }
    
    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        print("VISIT RECEIVED")
        print(visit)
        
        let loc = Location(lat: visit.coordinate.latitude, long: visit.coordinate.longitude, confidence: 1)
        var newLocs: [Location] = []
        var didAppend: Bool = false
        if let locations = try? JSONDecoder().decode([Location].self, from: UserDefaults.standard.data(forKey: "visitTracking") ?? Data()) {
            for ll in locations {
                if (ll.long + 0.0001 >= loc.long || ll.long - 0.0001 <= loc.long) && (ll.lat + 0.0001 >= loc.lat || ll.lat - 0.0001 <= loc.lat) {
                    var finLoc = Location(lat: ll.lat, long: ll.long, confidence: ll.confidence + loc.confidence)
                    if finLoc.confidence >= 3 {
                        //The visit has been made at least 3 times
                        self.nameFromLocation(loc) { placeName in
                            UserDefaults.standard.set(loc.lat, forKey: "notificationLat")
                            UserDefaults.standard.set(loc.long, forKey: "notificationLong")
                            NotificationManager.shared.sendLocalNotification(title: "SymPlace - Suggested Location", body: "We see you visit \(placeName) often! Do you want to leave a review?", location: loc)
                        }
                    }
                    newLocs.append(finLoc)
                    didAppend = true
                } else {
                    newLocs.append(ll)
                }
            }
        }
        if !didAppend {
            newLocs.append(loc)
        }
        UserDefaults.standard.set(try? JSONEncoder().encode(newLocs), forKey: "visitTracking")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !self.initialPosition {
            locations.last.map {
                region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude),
                    span: MKCoordinateSpan(latitudeDelta: self.region.span.latitudeDelta, longitudeDelta: self.region.span.longitudeDelta)
                )
            }
            self.initialPosition = true
        }
        
        self.userLocation = locations.last
    }
    
    func nameFromLocation(_ loc: Location, completion: @escaping (String) -> Void) {
        let locationURL = URL(string: "https://api.halz.dev/places/name/\(loc.long)/\(loc.lat)")
        
        URLSession.shared.dataTask(with: URLRequest(url: locationURL!)) { data, response, error in
            print("DATA TASK RETURNED")
            guard data != nil else {
                print("NO DATA SAD BOI HOURS")
                return
            }
            if let json = try? JSON(data: data!) {
                completion(json["data"]["name"].stringValue)
            } else {
                completion("")
            }
        }.resume()
    }
    
    public func launchSetup() {
        print("LOCATION MANAGER LAUNCH SETUP RUNNING")
    }
}
