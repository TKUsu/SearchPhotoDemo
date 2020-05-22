//
//  AlbumViewModel.swift
//  SearchPhotoDemo
//
//  Created by Judy on 2020/5/21.
//  Copyright © 2020 SuJustin. All rights reserved.
//

import Foundation

typealias AlBum = [PhotoCellViewModel]
protocol AlbumViewModelDelegate: NSObject {
    func didRequestAlbum()
    func didRequestError(code: String?, log: String?)
}
class AlbumViewModel {
    weak var delegate: AlbumViewModelDelegate?
    
    var album: AlBum = []
    
    fileprivate var manager = NetworkManager()
    
    func requestAlbum(search text: String, perPage: String) {
        let parameters: URLParameters = [
            "api_key": Flickr.api_yek,
            "text": text,
            "per_page": perPage,
            "format": "json",
            "nojsoncallback": "1"
        ]
        manager.requestWSURLJSON(.search, urlParameter: parameters, resType: Search.Response.self) {
            (res, error) in
            guard let res = res, error == nil else{
                self.delegate?.didRequestError(code: nil, log: error?.localizedDescription)
                return
            }
            self.album = res.photos.photo.map({ (photo) -> PhotoCellViewModel in
                return PhotoCellViewModel(id: photo.id, title: photo.title, imageURL: photo.imageURL)
            })
            favoriteAlbum.sync(with: &self.album){
                self.delegate?.didRequestAlbum()
            }
        }
    }
    
    func updatefavorite(photo: PhotoCellViewModel) {
        favoriteAlbum.update(photo: photo)
        NotificationCenter.default.post(name: .updatefavorite, object: nil)
        // TODO: Save
    }
}
