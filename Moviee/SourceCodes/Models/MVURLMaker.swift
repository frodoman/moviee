//
//  URLMaker.swift
//  Moviee
//
//  Created by Xinghou Liu on 15/05/2018.
//  Copyright © 2018 Xmart Soft Ltd. All rights reserved.
//

import UIKit

class MVURLMaker: NSObject
{
    static func collectionQueryUrlWith(_ keyword: String!)->String!
    {
        // example:
        // https://api.themoviedb.org/3/search/collection?api_key=xxx&query=Avengers&page=1
        let url = ConstUrlTextCollectionSearchMain + "?api_key=" + ConstAPIKey + "&query=" + keyword + "&page=1"
        return url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
    }
    
    static func collectionMoviesUrlWith(_ collectionId: String!)->String!
    {
        // example:
        // https://api.themoviedb.org/3/collection/99090?api_key=ad358c8a9834dcfc74af82859aa03a62&language=en-US
        let url = ConstUrlTextCollectionDetailsMain + "/" + collectionId + "?api_key=" + ConstAPIKey
        return url
    }
    
    static func movieDetailsUrlWith(_ movieId: String!)->String!
    {
        // example:
        // https://api.themoviedb.org/3/movie/9999889?api_key=ad358c8a9834dcfc74af82859aa03a62&language=en-US
        let url = ConstUrlTextMovieDetailsMain + movieId + "?api_key=" + ConstAPIKey
        return url
    }
    
    // MARK: - Image
    static func imageURLForPath(_ path: String!) -> String!
    {
        let imgUrl = ConstUrlTextImageDomain + path
        return imgUrl
    }
    
    //TODO: Return a local file path/URL for a image path
    static func imageFileURLForPath(_ path: String!) -> String?
    {
        return nil
    }
    //TODO: check if a image file exist
    static func imageFileExistFor(_ path: String!) -> Bool
    {
        return false
    }
}
