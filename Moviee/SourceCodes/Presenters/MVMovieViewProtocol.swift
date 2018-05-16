//
//  MVMovieViewProtocol.swift
//  Moviee
//
//  Created by Xinghou Liu on 15/05/2018.
//  Copyright © 2018 Xmart Soft Ltd. All rights reserved.
//

import Foundation

@objc protocol MVMovieViewProtocol: NSObjectProtocol {
    func startWaiting()
    func stopWaiting()
    
    @objc optional func showPlayingMovies( _ movies: [MVMovie]?)
    @objc optional func showMovieDetails(_ movie: MVMovie?)
    @objc optional func showCollectionMovies(_ movies: [MVMovie]?)
}
