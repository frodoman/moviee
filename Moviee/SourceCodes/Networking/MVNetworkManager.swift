//
//  MNetworkManager.swift
//  Moviee
//
//  Created by Xinghou Liu on 15/05/2018.
//  Copyright © 2018 Xmart Soft Ltd. All rights reserved.
//

import UIKit

class MVNetworkManager: NSObject {
    static let shared = MVNetworkManager()
    
    override init() {
        super.init()
    }
    
    func requestNowPlayingMoviesWith(_ handler: @escaping ([MVMovie]?)->Void ) -> Void
    {
        let task = URLSession.shared.dataTask(with:  URL.init(string:  ConstUrlTextNowPlaying)!)
        { (mData, response, error) in
            
            guard error == nil, mData != nil
            else
            {
                handler(nil)
                return
            }
            
            if let dicResult = try? JSONSerialization.jsonObject(with: mData!, options: .allowFragments) as? [String: Any]
            {
                if let movieArray = dicResult![ConstJsonKeyResults] as? [[String: Any]]
                {
                    var returnMovies : [MVMovie] = []
                    for oneMovie in movieArray
                    {
                        let aMovie = MVMovie.init(fromDictionary: oneMovie)
                        returnMovies.append(aMovie)
                    }
                    handler(returnMovies)
                    return
                }
            }
            
            handler(nil)
        }
        
        task.resume()
    }
}
