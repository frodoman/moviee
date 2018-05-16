//
//  UIView+Common.swift
//  Moviee
//
//  Created by Xinghou.Liu on 16/05/2018.
//  Copyright © 2018 Xmart Soft Ltd. All rights reserved.
//

import Foundation
import UIKit

extension UIView
{
    func showWaitingAnimation()
    {
        let spinner = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        spinner.tag = ConstViewTagSpinner
        spinner.frame = CGRect(x: (self.frame.size.width - ConstViewSpinnerWidth)/2.0,
                               y: (self.frame.size.height - ConstViewSpinnerWidth)/2.0,
                               width: ConstViewSpinnerWidth,
                               height: ConstViewSpinnerWidth)
        
        self.addSubview(spinner)
    }
    
    func hideWaitingAnimation()
    {
        for aView in self.subviews
        {
            if let spinner = aView as? UIActivityIndicatorView,
               aView.tag == ConstViewTagSpinner
            {
                spinner.stopAnimating()
                spinner.removeFromSuperview()
                break
            }
        }
    }
}
