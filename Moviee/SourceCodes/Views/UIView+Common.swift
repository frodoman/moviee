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
    // show a waiting animation in a view with dark background
    func showWaitingAnimation()
    {
        let maskView = UIView.init(frame: self.bounds)
        maskView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        maskView.tag = ConstViewTagMask
        maskView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(maskView)
        
        let spinner = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        spinner.tag = ConstViewTagSpinner
        spinner.center = maskView.center;
        spinner.startAnimating()
        
        maskView.addSubview(spinner)
        
    }
    
    // remove the waiting animation
    func hideWaitingAnimation()
    {
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
