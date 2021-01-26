//
//  HashLabel.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 08/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit

class HashLabel: UILabel, ViewUpdater {
    
    //MARK: ViewUpdater
    
    func update(with hash: AnyHashable) {
        text = String((hash as! String).prefix(5))
    }
}
