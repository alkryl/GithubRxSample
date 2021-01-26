//
//  AuthorLoginLabel.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 08/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit

class AuthorLoginLabel: UILabel, ViewUpdater {
    
    //MARK: ViewUpdater
    
    func update(with login: AnyHashable) {
        text = (login as! String)
    }
}
