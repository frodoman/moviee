//
//  URLMaker.swift
//  Moviee
//
//  Created by Xinghou Liu on 15/05/2018.
//  Copyright © 2018 Xmart Soft Ltd. All rights reserved.
//

import UIKit

class URLMaker: NSObject
{
    static func collectionDetailsUrlWith(_ collectionId: String!)->String!
    {
        // example:
        // https://api.themoviedb.org/3/collection/99090?api_key=ad358c8a9834dcfc74af82859aa03a62&language=en-US
        let url = ConstUrlTextCollectionDetailsMain + collectionId + "?api_key=" + ConstAPIKey
        return url
    }
    
    static func movieDetailsUrlWith(_ movieId: String!)->String!
    {
        // example:
        // https://api.themoviedb.org/3/movie/9999889?api_key=ad358c8a9834dcfc74af82859aa03a62&language=en-US
        let url = ConstUrlTextMovieDetailsMain + movieId + "?api_key=" + ConstAPIKey
        return url
    }
}
