//
//  ViewController.swift
//  Moviee
//
//  Created by Xinghou.Liu on 15/05/2018.
//  Copyright © 2018 Xmart Soft Ltd. All rights reserved.
//

import UIKit

class MVMainViewController: UIViewController, MVMovieViewProtocol {
    
    let moviePresenter = MVMoviePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = ConstTitleNowPlaying
        self.moviePresenter.attachTo(self)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.moviePresenter.getNowPlayingMovies()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func startWaiting() {
        self.view.showWaitingAnimation()
    }

    func stopWaiting() {
         self.view.hideWaitingAnimation()
    }
    
    func showPlayingMovies(_ movies: [MVMovie]?) {
        if let num = movies?.count
        {
            print("\(num) Movies Found ")
        }
        else
        {
            print("No movies")
        }
    }
}

