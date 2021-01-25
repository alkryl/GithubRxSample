//
//  ConfirmButton.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 08/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit

@IBDesignable class ConfirmButton: UIButton {

    //MARK: IBInspectable
    
    @IBInspectable private var borderWidth: CGFloat {
        set { layer.borderWidth = newValue }
        get { layer.borderWidth }
    }
    
    @IBInspectable private var borderColor: UIColor? {
        set { layer.borderColor = newValue?.cgColor }
        get { layer.borderColor?.UIColor }
    }
    
    @IBInspectable private var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { layer.cornerRadius  }
    }
}
