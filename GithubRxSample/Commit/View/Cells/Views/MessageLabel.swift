//
//  MessageLabel.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 08/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit

class MessageLabel: UILabel, ViewUpdater {
    
    //MARK: ViewUpdater
    
    func update(with message: AnyHashable) {
        text = (message as! String)
    }
}
