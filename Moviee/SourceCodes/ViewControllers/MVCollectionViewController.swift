//
//  MVCollectionViewController.swift
//  Moviee
//
//  Created by Xinghou.Liu on 16/05/2018.
//  Copyright © 2018 Xmart Soft Ltd. All rights reserved.
//

import UIKit

class MVCollectionViewController: MVBaseViewController {

    var movieCollection: MVCollection?
    
    init(withCollection collection: MVCollection! )
    {
        super.init(nibName: "MVCollectionViewController", bundle: nil)
        self.movieCollection = collection
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = self.movieCollection?.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // TODO: Implement UI to show collection
}
