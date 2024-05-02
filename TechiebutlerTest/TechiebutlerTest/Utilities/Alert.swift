//
//  Alert.swift
//  TechiebutlerTest
//
//  Created by sandeep kaur on 02/05/24.
//

import UIKit


class Alert {
    static func show(title: String = "", message: String, buttonTitle: String  = "Ok") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        alertController.addAction(defaultAction)
        if let topvc = UIApplication.getTopViewController(){
            topvc.present(alertController, animated: true, completion: nil)
        }
        
    }
    
}
