//
//  UIViewControllerExtension.swift
//  test task
//
//  Created by Galina Fedorova on 15/05/2018.
//  Copyright © 2018 Galina Fedorova. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func addAlert(title:String, message:String, activitiIndicator:UIActivityIndicatorView?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action) in
            activitiIndicator?.stopAnimating()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setActivityIndicator(axctivityIndicator:UIActivityIndicatorView){
        self.view.addSubview(axctivityIndicator)
        axctivityIndicator.hidesWhenStopped = true
        axctivityIndicator.center = self.view.center
        axctivityIndicator.color = UIColor.black
        axctivityIndicator.startAnimating()
    }
    
}
