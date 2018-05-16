//
//  MNetworkManager.swift
//  Moviee
//
//  Created by Xinghou Liu on 15/05/2018.
//  Copyright © 2018 Xmart Soft Ltd. All rights reserved.
//

import UIKit

typealias MVMovieListCallBack = ([MVMovie]?)->Void

class MVNetworkManager: NSObject {
    static let shared = MVNetworkManager()
    
    let imageQueue = OperationQueue()
    
    override init() {
        super.init()
    }
    
    //MARK: - Movies API
    func requestNowPlayingMoviesWith(_ handler: @escaping MVMovieListCallBack ) -> Void
    {
        self.requestMovieListFrom(ConstUrlTextNowPlaying, callBack: handler)
    }
    
    func requestMovieListFrom( _ urlText: String!,
                               callBack handler : @escaping MVMovieListCallBack )
    {
        let url = URL.init(string: urlText)
        let task = URLSession.shared.dataTask(with: url!)
        { (mData, response, error) in
            
            guard error == nil, mData != nil
                else
            {
                handler(nil)
                return
            }
            
            if let dicResult = try? JSONSerialization.jsonObject(with: mData!, options: .allowFragments) as? [String: Any]
            {
                var movieArray = dicResult![ConstJsonKeyResults] as? [[String: Any]]
                if movieArray == nil
                {
                    movieArray = dicResult!["parts"] as? [[String: Any]]
                }
                
                if movieArray != nil
                {
                    var returnMovies : [MVMovie] = []
                    for oneMovie in movieArray!
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
    
    func requestMovieDetailsWith(movieId mId: Int!,
                             callBack handler: @escaping (MVMovie?)->Void) ->Void
    {
        let url = URL.init(string:  MVURLMaker.movieDetailsUrlWith( String(mId!)))
        let task = URLSession.shared.dataTask(with: url!) { (mData, response, error) in
            
            guard error == nil, mData != nil
                else
            {
                handler(nil)
                return
            }
            
            if let dicResult = try? JSONSerialization.jsonObject(with: mData!, options: .allowFragments) as? [String: Any]
            {
                let aMovie = MVMovie.init(fromDictionary: dicResult)
                handler(aMovie)
                return
            }
            
            handler(nil)
        }
        
        task.resume()
    }
    
    func requestCollectionWith(query keywords: String!,
                               callBack handler: @escaping ([MVCollection]?)->Void)
    {
        let urlText = MVURLMaker.collectionQueryUrlWith( keywords)
        let url = URL.init(string: urlText!)
        
        let task = URLSession.shared.dataTask(with: url!) { (mData, response, error) in
            
            guard error == nil, mData != nil
                else
            {
                handler(nil)
                return
            }
            
            if let dicResult = try? JSONSerialization.jsonObject(with: mData!, options: .allowFragments) as? [String: Any]
            {
                if let collectionArray = dicResult![ConstJsonKeyResults] as? [[String: Any]]
                {
                    var collections : [MVCollection] = []
                    for oneDic in collectionArray
                    {
                        let aCollection = MVCollection.init(fromDictionary: oneDic)
                        collections.append(aCollection)
                    }
                    handler(collections)
                    return
                }
            }
            
            handler(nil)
        }
        
        task.resume()
    }
    
    func requestCollectionMoviesFor( movie aMovie: MVMovie!,
                                    callBack handler: @escaping MVMovieListCallBack )
    {
        if let title = aMovie.title
        {
            var keywords = title
            if title.contains(":")
            {
                keywords = title.components(separatedBy: ":").first!
            }
            
            self.requestCollectionWith(query: keywords, callBack: { (collections) in
                guard let cArray = collections,
                    cArray.count > 0
                else
                {
                    handler(nil)
                    return
                }
                
                // TODO: fetch all movies for all collections,
                // For now, we will just fetch movies for the first collection
                let collectionId = String((collections![0]).collectionId)
                let urlText = MVURLMaker.collectionMoviesUrlWith(collectionId)
                self.requestMovieListFrom(urlText, callBack: handler)
            })
        }
    }
    
    // MARK: - Image API
    func requestImageFor(path imgPath: String!,
                         callback handler: @escaping (UIImage?)->Void)
    {
        //Use the local image
        if MVURLMaker.imageFileExistFor(imgPath)
        {
            if let imgDir = MVURLMaker.imageURLForPath(imgPath)
            {
                let img = UIImage.init(contentsOfFile: imgDir )
                handler(img)
                return
            }
        }
        
        //request image from server
        let urlText = MVURLMaker.imageURLForPath(imgPath)
        
        let operation = BlockOperation.init {
            var img : UIImage? = nil
            
            if let imgData = try? Data.init(contentsOf: URL.init(string: urlText!)!)
            {
                img = UIImage.init(data: imgData)
            }
            
            // TODO: - Save the image file locally
            // with the path name into the file system
            
            DispatchQueue.main.sync(execute: {
                 handler(img)
            })
        }
        
        self.imageQueue.addOperation(operation)
    }
}
