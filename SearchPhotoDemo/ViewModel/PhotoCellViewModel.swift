//
//  PhotoCellViewModel.swift
//  SearchPhotoDemo
//
//  Created by Judy on 2020/5/22.
//  Copyright © 2020 SuJustin. All rights reserved.
//

import UIKit

struct PhotoCellViewModel {
    var id: String
    var title: String
    var imageURL: String
    var isfavorite: Bool = false
    
    init(id: String, title: String, imageURL: String) {
        self.id = id
        self.title = title
        self.imageURL = imageURL
    }
    /// CoreData init
    init(id: String, title: String, imageURL: String, isfavorite: Bool) {
        self.id = id
        self.title = title
        self.imageURL = imageURL
        self.isfavorite = isfavorite
    }
    
    func download(complete: @escaping (_ image: UIImage?)->()) {
        NetworkManager().request(imageURL) {(data, error) in
            guard let data = data, error == nil else{
                print("Download \(self.title) error.\n[Error]: \(error!)")
                return
            }
            complete(UIImage(data: data))
        }
    }
}
