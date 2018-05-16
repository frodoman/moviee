//
//  ViewController.swift
//  Moviee
//
//  Created by Xinghou.Liu on 15/05/2018.
//  Copyright © 2018 Xmart Soft Ltd. All rights reserved.
//

import UIKit

class MVMainViewController: MVBaseViewController, MVMovieViewProtocol,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionViewMovies: UICollectionView!
    
    let moviePresenter = MVMoviePresenter()
    var movies: [MVMovie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = ConstTitleNowPlaying
        self.moviePresenter.attachTo(self)
        self.setupCollectionView()
    }

    override func viewDidAppear(_ animated: Bool) {
        
        if !self.viewDidAppeared
        {
            self.moviePresenter.getNowPlayingMovies()
        }
        
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - MVMovieViewProtocol
    func startWaiting() {
        self.view.showWaitingAnimation()
    }

    func stopWaiting() {
         self.view.hideWaitingAnimation()
    }
    
    func showPlayingMovies(_ movies: [MVMovie]?) {
        if let num = movies?.count
        {
            print("\(num) Movies Found ")
            self.movies = movies!
            self.collectionViewMovies.reloadData()
        }
        else
        {
            print("No movies")
        }
    }
    
    //MARK: - Setting UP UIs
    func setupCollectionView()
    {
        self.collectionViewMovies.register(UINib(nibName: ConstMovieCollectionCellId, bundle: nil), forCellWithReuseIdentifier: ConstMovieCollectionCellId)
    }
    
    //MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellID = ConstMovieCollectionCellId
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? MVMovieCollectionCell
        
        if( cell == nil)
        {
            self.collectionViewMovies.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? MVMovieCollectionCell
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let movieCell = cell as? MVMovieCollectionCell
        {
            movieCell.updateUIWithMovie(self.movies[indexPath.row])
        }
    }
    //MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = self.movies[indexPath.row]
        let detailsVC = MVMovieDetailsViewController.init(movie: selectedMovie, showCollection: true)
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfItemsPerRow = 2
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfItemsPerRow - 1))
        let size = (collectionView.bounds.width - totalSpace) / CGFloat(numberOfItemsPerRow)
        
        return CGSize(width: size, height: size*1.2)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

}

