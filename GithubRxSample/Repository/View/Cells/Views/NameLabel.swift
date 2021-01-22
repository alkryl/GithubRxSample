//
//  NameLabel.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 03/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit

class NameLabel: UILabel, ViewUpdater {
    
    //MARK: ViewUpdater
    
    func update(with name: AnyHashable) {
        text = (name as! String)
    }
}
