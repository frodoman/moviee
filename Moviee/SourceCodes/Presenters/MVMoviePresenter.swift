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
        
        MVNetworkManager.shared.requestNowPlayingMoviesWith { (movies) in
            DispatchQueue.main.sync(execute: {
                self.targetView?.stopWaiting()
                self.targetView?.showPlayingMovies!(movies)
            })
        }
    }
    
    func getMovieDetails(withId movieId: Int!)
    {
        self.targetView?.startWaiting()
    }
}
