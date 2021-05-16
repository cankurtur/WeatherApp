//
//  Util.swift
//  WeatherApp
//
//  Created by Can Kurtur on 16.05.2021.
//

import UIKit

fileprivate var aView : UIView?

// Here in the Util.swift file, an extension is defined to create the functions in order to "create" and "remove" the spinning wheel (spinner) which is used later when performing segue.

// The aim of creating spinner is to avoid the timing problem when performing segue and fetching the data from API at the same time. In case of not using the ActivityIndicator, it could be the case that the segue is being performed before any data received from the API.

extension WeatherViewController{
    
    func showSpinner(){
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
       
        let ai = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        ai.center = aView!.center
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView!)
        
        }
    
    func removeSpinner(){
            aView?.removeFromSuperview()
            aView = nil
        }
    }
    
    

