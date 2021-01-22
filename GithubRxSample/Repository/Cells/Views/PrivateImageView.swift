//
//  PrivateImageView.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 03/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit

class PrivateImageView: UIImageView, ViewUpdater {
    
    //MARK: ViewUpdater
    
    func update(with valuePrivate: AnyHashable) {
        image = (valuePrivate as! Bool) ? R.image.access() : R.image.free()
    }
}
