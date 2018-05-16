//
//  HotelModel.swift
//  test task
//
//  Created by Galina Fedorova on 07/05/2018.
//  Copyright © 2018 Galina Fedorova. All rights reserved.
//

import Foundation
import ObjectMapper

class HotelModel:ImmutableMappable{

    let id:Int
    let name:String
    let address:String
    let stars:Double
    let distance:Double
    let suites_availabilityString:String
    let suites_availability:[Int]?
    let photoURL:String?
    let lat:Double?
    let lon:Double?
    
    required init(map:Map) throws {
        id = try map.value("id")
        name = try map.value("name")
        address = try map.value("address")
        stars = try map.value("stars")
        distance = try map.value("distance")
        suites_availabilityString = try map.value("suites_availability")
        suites_availability = SuitesStringToSuitesIntArray(separatedChar: ":").transformFromJSON( try map.value("suites_availability"))
        photoURL = try? map.value("image")
        lat = try? map.value("lat")
        lon = try? map.value("lon")
    }
    
    func mapping(map: Map) {
        id >>> map["id"]
        name >>> map["name"]
        address >>> map["address"]
        stars >>> map["stars"]
        distance >>> map["distance"]
        suites_availability >>> (map["suites_availability"], SuitesStringToSuitesIntArray(separatedChar: ":"))
        photoURL >>> map["image"]
        lat >>> map["lat"]
        lon >>> map["lon"]
    }
    
}
