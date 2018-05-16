//
//  ViewController.swift
//  Moviee
//
//  Created by Xinghou.Liu on 15/05/2018.
//  Copyright © 2018 Xmart Soft Ltd. All rights reserved.
//

import UIKit

class MVMainViewController: MVBaseViewController {
    
    let movieGridController = MVMovieGridViewController()
    
    let moviePresenter = MVMoviePresenter()
    var movies: [MVMovie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = ConstTitleNowPlaying
        self.moviePresenter.attachTo(self)
        
        self.movieGridController.parentController = self;
    }

    override func viewDidAppear(_ animated: Bool) {
        
        if !self.viewDidAppeared
        {
            self.moviePresenter.getNowPlayingMovies()
            self.movieGridController.attachToView(self.view)
        }
        
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - MVMovieViewProtocol
extension MVMainViewController: MVMovieViewProtocol
{
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
            self.movies = movies!
            self.movieGridController.movies = movies!
        }
        else
        {
            print("No movies")
        }
    }
}

