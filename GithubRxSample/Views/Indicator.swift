//
//  Indicator.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 01/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit

class Indicator: UIActivityIndicatorView {
    
    //MARK: Initialization
    
    override init(style: UIActivityIndicatorView.Style) {
        super.init(style: style)
        
        self.customize(style)
        start()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: Methods
    
    func start() {
        startAnimating()
    }
    
    func stop() {
        stopAnimating()
    }
    
    //MARK: Private
    
    private func customize(_ viewStyle: UIActivityIndicatorView.Style) {
        style = viewStyle
        color = .darkGray
        hidesWhenStopped = true
    }
}
