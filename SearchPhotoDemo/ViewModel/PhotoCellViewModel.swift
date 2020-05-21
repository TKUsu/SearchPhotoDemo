//
//  PhotoCellViewModel.swift
//  SearchPhotoDemo
//
//  Created by Judy on 2020/5/22.
//  Copyright © 2020 SuJustin. All rights reserved.
//

import UIKit

struct PhotoCellViewModel {
    let title: String
    let imageURL: String
    
    init(title: String, imageURL: String) {
        self.title = title
        self.imageURL = imageURL
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
