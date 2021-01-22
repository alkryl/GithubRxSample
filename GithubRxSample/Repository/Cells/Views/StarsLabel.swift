//
//  StarsLabel.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 03/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit

class StarsLabel: UILabel, ViewUpdater {
    
    //MARK: ViewUpdater
    
    func update(with number: AnyHashable) {
        text = "\(number as! Int) ⭐︎"
    }
}
