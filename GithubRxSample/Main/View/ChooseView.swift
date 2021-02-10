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
    
    //MARK: IBInspectable
    
    @IBInspectable var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { layer.cornerRadius  }
    }
    
    //MARK: Rx
    
    private let db = DisposeBag()
    private let hideSubject = PublishSubject<Bool>()

    //MARK: Initialization
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        subscribe()
    }
    
    //MARK: Methods
    
    func animate() {
        animateView { [weak self] in
            self?.hideSubject.onNext(false)
        }
    }
    
    func animate(with handler: @escaping EmptyClosure) {
        hideSubject.onNext(true)
        animateView(scale: 2.5, size: CGSize(width: 100, height: 65), radius: 10.0, handler)
    }
    
    //MARK: Private
    
    private func animateView(scale: CGFloat = 1.0,
                 size: CGSize = CGSize(width: 70.0, height: 70.0),
                 radius: CGFloat = 35.0,
                 _ handler: EmptyClosure?) {
        
        animate([.scale(scale), .size(size), .corner(radius: radius)], completion: handler)
    }
}

//MARK: Subscriber

extension ChooseView: Subscriber {
    func subscribe() {
        hideSubject
            .do(onNext: { [weak self] hidden in
                self?.subviews.forEach { $0.isHidden = hidden }
            }).subscribe()
            .disposed(by: db)
    }
}
