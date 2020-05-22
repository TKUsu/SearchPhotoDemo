//
//  AlbumViewController.swift
//  SearchPhotoDemo
//
//  Created by Judy on 2020/5/21.
//  Copyright © 2020 SuJustin. All rights reserved.
//

import UIKit

class AlbumViewController: SuperViewController {
    static var storyBoardID: String = "AlbumViewController"
    
    var searchText: String!
    var perPage: String!
    
    var colV: UICollectionView!
    var refreshCtl: UIRefreshControl!
    
    fileprivate var viewModel: AlbumViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupView()
        
        loadData()
    }
    
    // MARK: - Private
    @objc fileprivate func loadData() {
        activityView.startAnimating()
        viewModel.requestAlbum(search: searchText, perPage: perPage)
    }
    
    private func setup(){
        viewModel = AlbumViewModel()
        viewModel.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        colV = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        colV.delegate = self
        colV.dataSource = self
        
        refreshCtl = UIRefreshControl(frame: CGRect(x: 0, y: 0, width: colV.bounds.width, height: 100))
        refreshCtl.tintColor = .lightGray
        refreshCtl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        colV.addSubview(refreshCtl)
        colV.alwaysBounceVertical = true
    }
    private func setupView(){
        // view and constraint
        view.insertSubview(colV, at: 0)
        colV.translatesAutoresizingMaskIntoConstraints = false
        colV.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        colV.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        colV.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        colV.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        colV.register(nibWithCellClass: AlbumCollectionViewCell.self)
    }
}

// MARK: - AlbumViewModel delegate
extension AlbumViewController: AlbumViewModelDelegate{
    func didRequestError(code: String?, log: String?) {
        presentAlert(title: "Error", subTitle: code, msg: log, actionTitle: "ok") {[weak self] (sender) in
            self?.activityView.stopAnimating()
            self?.navigationController?.popViewController()
        }
    }
    
    func didRequestAlbum() {
        DispatchQueue.main.async {[weak self] in
            self?.colV.reloadData()
            self?.activityView.stopAnimating()
            self?.refreshCtl.endRefreshing()
        }
    }
}

// MARK: - CollectionView delegate and dataSource
extension AlbumViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width / 2 - 10
        return CGSize(width: width, height: width)
    }
}
extension AlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.album.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: AlbumCollectionViewCell.self, for: indexPath)
        
        cell.setup(with: viewModel.album[indexPath.row])
        cell.onFavorite = onfavorite(_:)
        
        return cell
    }
    fileprivate func onfavorite(_ photo: PhotoCellViewModel){
        viewModel.updatefavorite(photo: photo)
    }
}
