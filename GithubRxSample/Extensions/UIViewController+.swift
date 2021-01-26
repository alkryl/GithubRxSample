//
//  UIViewController+.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 25.12.2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideNavigationBar(_ hide: Bool, animated: Bool = true) {
        navigationController?.setNavigationBarHidden(hide, animated: animated)
    }
    
    func hideBackButtonText() {
        navigationItem.backBarButtonItem =
            UIBarButtonItem(title: .empty, style: .plain, target: nil, action: nil)
    }
}
