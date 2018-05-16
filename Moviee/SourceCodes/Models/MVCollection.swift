//
//  MVCollection.swift
//  Moviee
//
//  Created by Xinghou Liu on 15/05/2018.
//  Copyright © 2018 Xmart Soft Ltd. All rights reserved.
//

import UIKit

class MVCollection: NSObject {

    var collectionId : Int! = 0
    var backdrop_path: String? = ""
    var poster_path: String? = ""
    var name: String? = ""
    
    init(fromDictionary dic: [String: Any]!)
    {
        super.init()
        
        if let idNum = dic["id"] as? NSNumber
        {
            self.collectionId = idNum.intValue
        }
        
        self.poster_path = dic["poster_path"] as? String
        self.backdrop_path = dic["backdrop_path"] as? String
        self.name = dic["name"] as? String
    }
}
