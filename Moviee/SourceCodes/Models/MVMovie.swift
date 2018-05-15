//
//  MVMovie.swift
//  Moviee
//
//  Created by Xinghou Liu on 15/05/2018.
//  Copyright © 2018 Xmart Soft Ltd. All rights reserved.
//

import UIKit

class MVMovie: NSObject {
    var id: Int? = 0
    var name: String? = ""
    var belongs_to_collection: MVCollection?
    
    init(fromDictionary dic: [String: Any]!)
    {
        super.init()
        
        if let idNum = dic["id"] as? NSNumber
        {
            self.id = idNum.intValue
        }
        
        self.name = dic["name"] as? String
        
        if let collectionDic = dic["belongs_to_collection"] as? [String: Any]
        {
            self.belongs_to_collection = MVCollection.init(fromDictionary: collectionDic);
        }
        
    }
}