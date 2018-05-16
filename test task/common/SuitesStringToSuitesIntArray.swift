//
//  Transforn.swift
//  test task
//
//  Created by Galina Fedorova on 09/05/2018.
//  Copyright © 2018 Galina Fedorova. All rights reserved.
//

import Foundation
import ObjectMapper

open class SuitesStringToSuitesIntArray: TransformType {
    
    public typealias Object = [Int]
    public typealias JSON = String
    private var separatedChar:Character
    
    public init(separatedChar:Character) {
        self.separatedChar = separatedChar
    }
    
    open func transformFromJSON(_ value: Any?) -> [Int]? {
        if let valueString = value as? String {
            let arrayOfString = valueString.split(separator: separatedChar)
            let arrayOfInt = arrayOfString.map{ Int($0) }
            if let array = arrayOfInt as? [Int] {
                return array
            }else{
                return nil
            }
        }
        return nil
    }
    
    open func transformToJSON(_ value: [Int]?) -> String? {
        var result:String?
        if let valueInt = value{
            if valueInt.count>1{
                var index = 0
                for char in valueInt{
                    if index<(valueInt.count-2){
                        result?.append(String(char)+String(separatedChar))
                        index+=1
                    }else{
                        result?.append(String(char))
                    }
                }
            }else{
                result?.append(String(valueInt[0]))
            }
        }   
        return result
    }
}

