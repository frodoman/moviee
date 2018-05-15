//
//  ViewController.swift
//  Moviee
//
//  Created by Xinghou.Liu on 15/05/2018.
//  Copyright © 2018 Xmart Soft Ltd. All rights reserved.
//

import UIKit

class MVMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = ConstTitleNowPlaying
        
        MVNetworkManager.shared.requestNowPlayingMoviesWith { (movies) in
            guard let dMovies = movies, dMovies.count > 0
                else
            {
                return
            }
            
            print(dMovies)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

