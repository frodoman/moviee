//
//  Consts.swift
//  Moviee
//
//  Created by Xinghou.Liu on 15/05/2018.
//  Copyright © 2018 Xmart Soft Ltd. All rights reserved.
//

import Foundation
import UIKit

// API URLs
let ConstAPIKey = "ad358c8a9834dcfc74af82859aa03a62"
let ConstUrlTextNowPlaying = "https://api.themoviedb.org/3/movie/now_playing?api_key="+ConstAPIKey+"&page=1"
let ConstUrlTextMovieDetailsMain = "https://api.themoviedb.org/3/movie/"
let ConstUrlTextCollectionDetailsMain = "https://api.themoviedb.org/3/collection"
let ConstUrlTextCollectionSearchMain = "https://api.themoviedb.org/3/search/collection"
let ConstUrlTextImageDomain = "https://image.tmdb.org/t/p/w500/"

// titles
let ConstTitleNowPlaying = "Now Playing"

// For JSON keys
let ConstJsonKeyResults = "results"

// Animation
let ConstViewTagMask: Int    = 894382
let ConstViewTagSpinner: Int = 123867
let ConstViewSpinnerWidth: CGFloat = 50.0

// Movie
let ConstMovieCollectionCellId = "MVMovieCollectionCell"
