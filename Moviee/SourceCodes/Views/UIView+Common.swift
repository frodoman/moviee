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
        let maskView = UIView.init(frame: self.bounds)
        maskView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        maskView.tag = ConstViewTagMask
        maskView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        let spinner = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        spinner.tag = ConstViewTagSpinner
        spinner.center = maskView.center;
        spinner.startAnimating()
        
        maskView.addSubview(spinner)
        
        self.addSubview(maskView)
    }
    
    func hideWaitingAnimation()
    {
//        for aView in self.subviews
//        {
//            if let spinner = aView as? UIActivityIndicatorView,
//               aView.tag == ConstViewTagSpinner
//            {
//                spinner.stopAnimating()
//                spinner.removeFromSuperview()
//                break
//            }
//        }
        for aView in self.subviews
        {
            if aView.tag == ConstViewTagMask
            {
                aView.removeFromSuperview()
                break
            }
        }
    }
}
