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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    override init(style: UIActivityIndicatorView.Style) {
        super.init(style: style)
        createUI()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: Private
    
    private func createUI() {
        style = .medium
        color = .darkGray
        startAnimating()
        hidesWhenStopped = true
    }
}
