//
//  LanguageCircleView.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 02/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit

@IBDesignable class LanguageCircleView: UIView, ViewUpdater {
    
    //MARK: IBInspectable
    
    @IBInspectable private var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { layer.cornerRadius  }
    }
    
    //MARK: ViewUpdater
    
    func update(with language: AnyHashable) {
        backgroundColor = {
            switch Language(rawValue: language as! String) ?? .other {
            case .swift:      return R.color.swift()
            case .objectiveC: return R.color.objectiveC()
            case .assembly:   return R.color.assembly()
            case .javaScript: return R.color.javaScript()
            case .python:     return R.color.python()
            case .java:       return R.color.java()
            case .html:       return R.color.html()
            case .c:          return R.color.c()
            default:          return R.color.default()
            }
        }()
    }
}
