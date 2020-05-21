//
//  ViewController.swift
//  SearchPhotoDemo
//
//  Created by Judy on 2020/5/21.
//  Copyright © 2020 SuJustin. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    static var storyBoardID: String = "SearchViewController"
    
    @IBOutlet weak var Fid_search: UITextField!
    @IBOutlet weak var Fid_prePage: UITextField!
    
    fileprivate let segue_album = "toAlbum"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
    }

    @IBAction func searchAction(_ sender: UIButton) {
        
    }
    
    // MARK: - Private
    private func setupStyle(){
        
    }
}

