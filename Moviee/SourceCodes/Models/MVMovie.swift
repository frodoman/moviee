//
//  MVMovie.swift
//  Moviee
//
//  Created by Xinghou Liu on 15/05/2018.
//  Copyright © 2018 Xmart Soft Ltd. All rights reserved.
//

import UIKit

class MVMovie: NSObject {
    public var id: Int! = 0
    public var title: String? = ""
    public var imgPath: String? = ""
    
    // TODO: - Move the following properties to a sub class
    // Maybe name it as MVMovieDetails
    // for details
    var overView: String? = ""
    var belongs_to_collection: MVCollection?
    var rating: NSNumber?
    var backdropPath: String? = ""
    
    init(fromDictionary dic: [String: Any]!)
    {
        super.init()
        
        if let idNum = dic["id"] as? NSNumber
        {
            self.id = idNum.intValue
        }
        
        self.title = dic["title"] as? String
        self.imgPath = dic["poster_path"] as? String
        self.rating = dic["vote_average"] as? NSNumber
        self.overView = dic["overview"] as? String
        self.backdropPath = dic["backdrop_path"] as? String
        
        if let collectionDic = dic["belongs_to_collection"] as? [String: Any]
        {
            self.belongs_to_collection = MVCollection.init(fromDictionary: collectionDic);
        }
        
    }
}
