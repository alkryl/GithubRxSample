//
//  DescriptionLabel.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 03/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit

class DescriptionLabel: UILabel, ViewUpdater {
    
    //MARK: ViewUpdater
    
    func update(with descr: AnyHashable) {
        text = (descr as! String)
    }
}
