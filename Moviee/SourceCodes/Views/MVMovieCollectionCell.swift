//
//  MVMovieCollectionCell.swift
//  Moviee
//
//  Created by Xinghou.Liu on 16/05/2018.
//  Copyright © 2018 Xmart Soft Ltd. All rights reserved.
//

import UIKit

class MVMovieCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageViewPost: UIImageView!
    @IBOutlet weak var labelMovieName: UILabel!
    
    var movieData: MVMovie?
    var lastImagePath: String! = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateUIWithMovie(_ movie: MVMovie!)
    {
        self.movieData = movie
        self.labelMovieName.text = self.movieData?.title
        
        if self.lastImagePath != self.movieData?.imgPath 
        {
            self.requestPostImage()
        }
    }
    
    func requestPostImage()
    {
        
    }
}
