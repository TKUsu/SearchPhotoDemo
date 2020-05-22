//
//  FavoriteCollectionViewController.swift
//  SearchPhotoDemo
//
//  Created by Judy on 2020/5/22.
//  Copyright © 2020 SuJustin. All rights reserved.
//

import UIKit

class FavoriteCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    static let nibName = "FavoriteCollectionViewController"
    
    fileprivate var viewModel = FavoriteCollectionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindHandle()
        self.collectionView!.register(nibWithCellClass: AlbumCollectionViewCell.self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.addObserver()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    fileprivate func bindHandle(){
        viewModel.updateHandle = {[weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    // MARK: UICollectionViewLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width / 2 - 10
        return CGSize(width: width, height: width)
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return favoriteAlbum.album.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: AlbumCollectionViewCell.self, for: indexPath)
    
        cell.setup(with: favoriteAlbum.album[indexPath.row])
        cell.onFavorite = viewModel.updatefavorite
        
        return cell
    }
}
