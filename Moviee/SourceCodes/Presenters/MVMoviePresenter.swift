//
//  MVMoviePresenter.swift
//  Moviee
//
//  Created by Xinghou Liu on 15/05/2018.
//  Copyright © 2018 Xmart Soft Ltd. All rights reserved.
//

import UIKit

class MVMoviePresenter: NSObject {
    weak private var targetView: MVMovieViewProtocol?
    
    func attachTo( _ target: MVMovieViewProtocol?)
    {
        self.targetView = target
    }
    
    func detach()
    {
        self.targetView = nil
    }
    
    func getNowPlayingMovies()
    {
        self.targetView?.startWaiting()
        
        MVNetworkManager.shared.requestNowPlayingMovies { (movies) in
            DispatchQueue.main.sync(execute: {
                self.targetView?.stopWaiting()
                self.targetView?.showPlayingMovies!(movies)
            })
        }
    }
    
    func getMovieDetails(withId movieId: Int!)
    {
        self.targetView?.startWaiting()
        MVNetworkManager.shared.requestMovieDetails(with: movieId) { (aMovie) in
            DispatchQueue.main.async(execute: {
                self.targetView?.stopWaiting()
                self.targetView?.showMovieDetails!(aMovie)
            })
        }
    }
    
    func getCollectionMoviesFor(movie aMovie: MVMovie!)
    {
        self.targetView?.startWaiting()
        MVNetworkManager.shared.requestCollectionMovies(forMovie: aMovie) { (movies) in
            DispatchQueue.main.sync(execute: {
                self.targetView?.stopWaiting()
                self.targetView?.showCollectionMovies!(movies)
            })
        }
    }
    
}
