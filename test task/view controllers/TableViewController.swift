//
//  TableViewController.swift
//  test task
//
//  Created by Galina Fedorova on 07/05/2018.
//  Copyright © 2018 Galina Fedorova. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController{
 
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    private var requestManager:RequestManagerProtocol = RequestManager()
    private var arrayOfHotel:[HotelModel]?
    private var activityIndicator = UIActivityIndicatorView()
    private var checkInternetConnection = CheckInternetConnection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigationBarWidth  = self.navigationController?.navigationBar.frame.width{
            self.segmentControl.frame.size.width = navigationBarWidth-40
        }
        
        segmentControl.isHidden = true
        setActivityIndicator(axctivityIndicator: activityIndicator)
        
        if !checkInternetConnection.isConnectedToNetwork(){
            addAlert(title: "Internet Connection not Available!", message: "Сheck your internet connection", activitiIndicator: self.activityIndicator)
        } else {
            
            requestManager.callbackForHotelsInfo = { (hotels, error) in
                
                if let error = error{
                    self.addAlert(title: "Error", message: error.localizedDescription, activitiIndicator: self.activityIndicator)
                }
                
                guard let hotels = hotels else {return}
                self.arrayOfHotel = hotels
                
                DispatchQueue.main.async {
                    self.segmentControl.isHidden = false
                    self.activityIndicator.stopAnimating()
                    self.tableView.reloadData()
                }
                
            }
            self.requestManager.requestForHotelsInfo(urlString: "https://raw.githubusercontent.com/iMofas/ios-android-test/master/0777.json")
        }
    }
    
    @IBAction func sortedByParamrtes(_ sender: UISegmentedControl) {
        arrayOfHotel = arrayOfHotel?.sortedByParametr(parametr: sender.selectedSegmentIndex, array: arrayOfHotel)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = arrayOfHotel?.count{
            return count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.configure(with: arrayOfHotel?[indexPath.row])
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController{
            guard let id = arrayOfHotel?[indexPath.row].id else{return}
            vc.id = String(id)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
