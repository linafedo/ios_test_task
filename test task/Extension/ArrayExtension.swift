//
//  UISegmentControlExtension.swift
//  test task
//
//  Created by Galina Fedorova on 15/05/2018.
//  Copyright © 2018 Galina Fedorova. All rights reserved.
//

import Foundation
import UIKit

extension Array{
    
    func sortedByDistance(array:[HotelModel]?) -> [HotelModel]?{
        let sortArray : [HotelModel]?
        sortArray = array?.sorted(){$0.distance < $1.distance}
        return sortArray
    }
    
    func sortedByStars(array:[HotelModel]?) -> [HotelModel]?{
        let sortArray : [HotelModel]?
        
        sortArray = array?.sorted(by: { (first, two) -> Bool in
            if let firstItem = first.suites_availability, let secondItem = two.suites_availability{
                return firstItem.count > secondItem.count
            }else{
                return false
            }
        })
        return sortArray
    }
    
    func sortedByParametr(parametr:Int, array:[HotelModel]?)->[HotelModel]?{
        if parametr == 0{
            return sortedByDistance(array: array)
        }else{
            return sortedByStars(array: array)
        }
    }
    
}
