//
//  AlbumCollectionViewCell.swift
//  SearchPhotoDemo
//
//  Created by Judy on 2020/5/21.
//  Copyright © 2020 SuJustin. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var Lbl_title: UILabel!
    @IBOutlet weak var Btn_favorite: UIButton!
    
    var photo: PhotoCellViewModel!
    var onFavorite: ((_ photo: PhotoCellViewModel)->())!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgV.image = nil
        Lbl_title.text = ""
    }
    
    func setup(with photo: PhotoCellViewModel) {
        self.photo = photo
        
        self.Lbl_title.text = photo.title
        DispatchQueue.init(label: "downloadURL").async {
            photo.download{[weak self] image in
                DispatchQueue.main.async {
                    self?.imgV.image = image
                }
            }
        }
    }
    @IBAction func favoriteAction(_ sender: UIButton) {
        photo.isfavorite = !photo.isfavorite
        if let image = photo.isfavorite ? UIImage.favorite : UIImage.unfavorite{
            self.Btn_favorite.setImageForAllStates(image)
        }
        onFavorite(photo)
    }
}
