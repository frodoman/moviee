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
    
    let imageQueue = OperationQueue()
    
    override init() {
        super.init()
    }
    
    //MARK: - Movies API
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
