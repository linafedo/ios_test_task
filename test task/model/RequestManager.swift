//
//  RequestManager.swift
//  test task
//
//  Created by Galina Fedorova on 07/05/2018.
//  Copyright © 2018 Galina Fedorova. All rights reserved.
//

import Foundation
import ObjectMapper

protocol RequestManagerProtocol{
    func requestForHotelsInfo(urlString:String)
    func requestForHotelDetails(id:String)
    var callbackForHotelsInfo:( ([HotelModel]?, Error?) -> () )?{get set}
    var callbackForHotelDetails:( (HotelModel?, Error?) -> () )?{get set}
}

class RequestManager:RequestManagerProtocol{
    
    var callbackForHotelsInfo:( ([HotelModel]?, Error?) -> () )?
    var callbackForHotelDetails:( (HotelModel?, Error?) -> () )?
    
    func requestForHotelsInfo(urlString:String){
        
        var arrayOfObject:[HotelModel]?
        if let url = URL(string: urlString){
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {return}
                
                guard error == nil else {
                    self.callbackForHotelsInfo?(nil,error)
                    return
                }
                
                do {
                    let json:Any? = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    arrayOfObject = Mapper<HotelModel>().mapArray(JSONObject: json)
                    self.callbackForHotelsInfo?(arrayOfObject, nil)
                }catch let error{
                    self.callbackForHotelsInfo?(nil, error)
                    print(error)
                }
                
            }.resume()
        }
        
    }
        
    func requestForHotelDetails(id:String){
        var detailHotelModel: HotelModel?
        let urlString = "https://raw.githubusercontent.com/iMofas/ios-android-test/master/" + id + ".json"
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { (data, responce, error) in
                guard let data = data else {return}
                
                guard error == nil else {
                    self.callbackForHotelDetails?(nil,error)
                    return
                }
                
                do {
                    let json:Any? = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    detailHotelModel = Mapper<HotelModel>().map(JSONObject: json)
                    self.callbackForHotelDetails?(detailHotelModel,nil)
                }catch let error{
                    self.callbackForHotelDetails?(nil,error)
                    print(error)
                }
                
            }.resume()
        }
    }
    

}
