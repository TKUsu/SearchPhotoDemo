//
//  Ext+UIColorTheme.swift
//  SearchPhotoDemo
//
//  Created by Judy on 2020/5/21.
//  Copyright © 2020 SuJustin. All rights reserved.
//

import UIKit

// Theme
extension UIColor{
    static var floatBG: UIColor{
        if #available(iOS 13.0, *) {
            return UIColor.label.withAlphaComponent(0.3)
        } else {
            return UIColor.black.withAlphaComponent(0.3)
        }
    }
}
