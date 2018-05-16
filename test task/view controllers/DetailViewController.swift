//
//  InfoViewController.swift
//  test task
//
//  Created by Galina Fedorova on 08/05/2018.
//  Copyright © 2018 Galina Fedorova. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    private var requestManager = RequestManager()
    private var hotelDetails:HotelModel?
    private let activityIndicator = UIActivityIndicatorView()
    private var checkInternetConnection = CheckInternetConnection()
    private let processor = CropEdgesImageProcessor(xPoint: 1, yPoint: 1)
    var id:String?
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var starsLabal: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var suitesAvailabilityLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setActivityIndicator(axctivityIndicator: activityIndicator)
        
        if !checkInternetConnection.isConnectedToNetwork(){
            addAlert(title: "Internet Connection not Available!", message: "Сheck your internet connection", activitiIndicator: self.activityIndicator)
        } else {
            requestManager.callbackForHotelDetails = { (detailOfHorel, error) in
                
                if let error = error{
                    self.addAlert(title: "Error", message: error.localizedDescription, activitiIndicator: self.activityIndicator)
                }
                
                guard let detailOfHorel = detailOfHorel else {return}
                self.hotelDetails = detailOfHorel
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.setLabelText()
                }
            }
            
            if let id = self.id{
                requestManager.requestForHotelDetails(id:id)
            }
        }
    }
    
    private func setLabelText(){
        
        if let hotelDetailsModel = self.hotelDetails{
            
            if let lat = hotelDetailsModel.lat,
                let lon = hotelDetailsModel.lon{
                
                self.hotelName.text = hotelDetailsModel.name
                self.addressLabel.text = hotelDetailsModel.address
                self.starsLabal.text = String(hotelDetailsModel.stars)
                self.distanceLabel.text = String(hotelDetailsModel.distance)
                self.suitesAvailabilityLabel.text = hotelDetailsModel.suites_availabilityString.replacingOccurrences(of: ":", with: ",")
                self.latLabel.text = String(lat)
                self.lonLabel.text = String(lon)
            }
            let imageUrl = hotelDetails?.photoURL
            let url:URL? = imageUrl != nil ? URL(string: "https://github.com/iMofas/ios-android-test/raw/master/"+imageUrl!) : nil
            self.photo.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "dummy200"), options: [.processor(self.processor)])
        }
    }
    
}
