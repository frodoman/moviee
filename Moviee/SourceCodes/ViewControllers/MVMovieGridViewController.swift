//
//  MVMovieGridViewController.swift
//  Moviee
//
//  Created by Xinghou Liu on 16/05/2018.
//  Copyright © 2018 Xmart Soft Ltd. All rights reserved.
//

import UIKit

class MVMovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    @IBOutlet weak var collectionViewMovies: UICollectionView!
    
    weak var parentController: UIViewController?
    var showNextDetails: Bool = true
    
    var movies: [MVMovie] = [] {
        didSet {
            self.collectionViewMovies.reloadData()
        }

    }
    
    init()
    {
        super.init(nibName: "MVMovieGridViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Setting UP UIs
    func setupCollectionView()
    {
        self.collectionViewMovies.register(UINib(nibName: ConstMovieCollectionCellId, bundle: nil), forCellWithReuseIdentifier: ConstMovieCollectionCellId)
    }
    
    func attachToView(_ aView: UIView!)
    {
        self.view.frame = aView.bounds;
        self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        aView.addSubview(self.view)
        
        if self.parentController?.view == aView &&
           self.parentController?.navigationController != nil
        {
            let oldFrame = self.view.frame
            let margin: CGFloat = 64.0
            self.view.frame = CGRect(x: 0, y: margin,
                                    width: oldFrame.size.width,
                                    height: oldFrame.size.height - margin)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
        let detailsVC = MVMovieDetailsViewController.init(movie: selectedMovie, showCollection: self.showNextDetails)
        self.parentController?.navigationController?.pushViewController(detailsVC, animated: true)
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
