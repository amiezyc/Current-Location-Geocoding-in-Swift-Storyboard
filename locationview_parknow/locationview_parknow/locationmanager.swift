//
//  locationmanager.swift
//  locationview_parknow
//
//  Created by 周雨橙 on 4/21/23.
//

import Foundation
import CoreLocation

struct Location {
    let title: String
    let coordinates: CLLocationCoordinate2D?
}
//model for location

class LocationManager: NSObject {
    static let shared = LocationManager()
    
    public func findLocations(with query: String, completion: @escaping (([Location])->Void)){
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(query) { places, error in
            guard let places = places, error == nil else {
                completion([])
                return
            }
            //geocode the adrress string
            //get a collection of places back and unwrap those places
            
            let models: [Location] = places.compactMap({ place in
                var name = ""
                //construct one by one
                if let locationName = place.name{
                    name += locationName
                }
                
                if let adminRegion = place.administrativeArea{
                    name += ",\(adminRegion)"
                }
                
                if let locality = place.locality{
                    name += ",\(locality)"
                }
                
                if let country = place.country{
                    name += ",\(country)"
                }
                
                print("\n\(place)\n\n")
                //compact map them into the respective model
                
                let result = Location(
                    title: name,
                    coordinates: place.location?.coordinate
                )
                
                return result
                
            })
            
            completion(models)
            //return to completion
        }
        
    }
    
}
