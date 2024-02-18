//
//  Utility.swift
//  NYTimesArticles
//
//  Created by Macbook on 15/02/2024.
//

import Foundation
import UIKit

final class Utility {
    
    static func addActivityIndicator(toView view:UIView) {
        
        let blockerView = UIView(frame: UIScreen.main.bounds)
        blockerView.backgroundColor = .clear
        blockerView.tag = 666
        
        let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        
        activityIndicatorView.center = CGPoint(x: blockerView.frame.width/2.0, y: blockerView.frame.height/2.0)
        activityIndicatorView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        activityIndicatorView.hidesWhenStopped = true
        
        activityIndicatorView.startAnimating()
        
        blockerView.addSubview(activityIndicatorView)
        
        view.addSubview(blockerView)
        
    }
    
    static func removeActivityIndicator(fromView view:UIView) {
        
        if let viewToBeRemoved = view.viewWithTag(666) {
            
            for subView in viewToBeRemoved.subviews {
                
                if subView.isKind(of: UIActivityIndicatorView.self)  {
                    
                    let subView = subView as! UIActivityIndicatorView
                    subView.stopAnimating()
                    viewToBeRemoved.removeFromSuperview()
                    
                }
            }
        }
        
    }
    
}
