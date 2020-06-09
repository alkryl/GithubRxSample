//
//  LanguageCircleView.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 02/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

@IBDesignable class LanguageCircleView: UIView {
    
    var language = BehaviorRelay(value: "")
    private let db = DisposeBag()
    
    //MARK: IBInspectable
    
    @IBInspectable var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { return layer.cornerRadius  }
    }
    
    //MARK: Initialization

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        bindUI()
    }
    
    //MARK: Methods
    
    private func bindUI() {
        language.asDriver()
            .map { language -> Languages.LanguagesEnum in
                return (Languages.LanguagesEnum(rawValue: language) ?? .other)
            }.map { (language) -> UIColor in
                switch language {
                case .swift:      return #colorLiteral(red: 0.9529411765, green: 0.6823529412, blue: 0.3529411765, alpha: 1)
                case .objectiveC: return #colorLiteral(red: 0.3215686275, green: 0.5607843137, blue: 0.968627451, alpha: 1)
                case .assembly:   return #colorLiteral(red: 0.4117647059, green: 0.3019607843, blue: 0.1215686275, alpha: 1)
                case .javaScript: return #colorLiteral(red: 0.937254902, green: 0.8745098039, blue: 0.4431372549, alpha: 1)
                case .python:     return #colorLiteral(red: 0.2666666667, green: 0.4470588235, blue: 0.631372549, alpha: 1)
                case .java:       return #colorLiteral(red: 0.6549019608, green: 0.4549019608, blue: 0.1882352941, alpha: 1)
                case .html:       return #colorLiteral(red: 0.8196078431, green: 0.337254902, blue: 0.2117647059, alpha: 1)
                case .c:          return #colorLiteral(red: 0.8745098039, green: 0.3490196078, blue: 0.4901960784, alpha: 1)
                default:          return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                }
            }.drive(self.rx.backgroundColor)
            .disposed(by: db)
    }
}
