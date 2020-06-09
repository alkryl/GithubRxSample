//
//  AvatarImageView.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 03/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

@IBDesignable class AvatarImageView: UIImageView {

    var urlString = BehaviorRelay(value: "")
    var imageSubject = PublishSubject<UIImage?>()
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
        urlString.asObservable()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInteractive))
            .flatMap { APIService().getData(.image($0)) }
            .map { UIImage(data: $0) }
            .asDriver(onErrorJustReturn: UIImage(named: "default.png"))
            .drive(onNext: { [unowned self] (image) in
                self.imageSubject.onNext(image)
            }).disposed(by: db)
        
        imageSubject.asObservable()
            .bind(to: self.rx.image)
            .disposed(by: db)
    }
}
