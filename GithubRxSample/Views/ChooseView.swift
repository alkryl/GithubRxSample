//
//  ChooseView.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 04/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Motion

@IBDesignable class ChooseView: UIView {
    
    private let db = DisposeBag()
    var hideSubviews = PublishSubject<Bool>()
    
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
    
    func animate(scale: CGFloat = 1.0,
                 size: CGSize = CGSize(width: 70.0, height: 70.0),
                 radius: CGFloat = 35.0,
                 _ handler: (() -> ())?) {
        
        self.animate([.scale(scale), .size(size), .corner(radius: radius)], completion: handler)
    }
    
    //MARK: Private
    
    private func bindUI() {
        hideSubviews.asObservable()
            .do(onNext: { [unowned self] hide in
                self.subviews.forEach { $0.isHidden = hide }
            }).subscribe()
            .disposed(by: db)
    }
}
