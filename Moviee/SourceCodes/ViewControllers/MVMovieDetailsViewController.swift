//
//  MVMovieDetailsViewController.swift
//  Moviee
//
//  Created by Xinghou.Liu on 16/05/2018.
//  Copyright © 2018 Xmart Soft Ltd. All rights reserved.
//

import UIKit

class MVMovieDetailsViewController: MVBaseViewController, MVMovieViewProtocol {

    @IBOutlet weak var buttonCollection: UIButton!
    @IBOutlet weak var textViewDetails: UITextView!
    @IBOutlet weak var movieImage: UIImageView!
    
    var includeCollection: Bool = false
    var movieData: MVMovie!
    var movieDetails: MVMovie?
    let moviePresenter = MVMoviePresenter()
    
    init(movie mData: MVMovie!, showCollection includeCollection: Bool)
    {
        super.init(nibName: "MVMovieDetailsViewController", bundle: nil)
        self.movieData = mData
        self.includeCollection = includeCollection
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.moviePresenter.attachTo(self)
        self.title = self.movieData.title
        self.movieImage.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if !self.viewDidAppeared
        {
            self.moviePresenter.getMovieDetails(withId: self.movieData.id)
            self.moviePresenter.getCollectionMoviesFor(movie: self.movieData)
        }
        super.viewDidAppear(animated)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - MVMovieViewProtocol
    func startWaiting() {
        self.view.showWaitingAnimation()
    }
    
    func stopWaiting() {
        self.view.hideWaitingAnimation()
    }
    
    func showMovieDetails(_ movie: MVMovie?) {
        if let movieDetails = movie
        {
            self.textViewDetails.text = movieDetails.overView
            self.getMovieImage(movieDetails.backdropPath)
            self.movieDetails = movieDetails
        }
    }
    
    func showCollectionMovies(_ movies: [MVMovie]?) {
        if let cMovies = movies
        {
            
        }
    }
    
    // MARK: -
    func getMovieImage( _ path: String?)
    {
        if let imgPath = path
        {
            self.startWaiting()
            MVNetworkManager.shared.requestImageFor(path: imgPath, callback: {[weak self] (anImage) in
                self?.movieImage.image = anImage
                
                self?.stopWaiting()
            })
        }
    }
    
    // MARK: - Collection
    func updateCollectionUI()
    {
        self.buttonCollection.isHidden = true
        
        if self.includeCollection
        {
            if let _ = self.movieDetails?.belongs_to_collection
            {
                self.buttonCollection.isHidden = false
            }
        }
    }
    
    @IBAction func buttonCollectionTapped(_ sender: UIButton!)
    {
        if let collection = self.movieDetails?.belongs_to_collection
        {
            let collectionVC = MVCollectionViewController.init(withCollection: collection)
            self.navigationController?.pushViewController(collectionVC, animated: true)
        }
    }
    
}
