//
//  AvatarImageView.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 03/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit
import Kingfisher

@IBDesignable class AvatarImageView: UIImageView, ViewUpdater {
    
    //MARK: IBInspectable
    
    @IBInspectable private var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { layer.cornerRadius  }
    }
    
    //MARK: ViewUpdater
    
    func update(with url: AnyHashable) {
        kf.setImage(with: URL(string: url as! String),
                    options: [.transition(.fade(0.2)), .cacheOriginalImage, .fromMemoryCacheOrRefresh])
    }
}
