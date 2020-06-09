//
//  AuthorImageView.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 08/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

@IBDesignable class AuthorImageView: UIImageView {

    var imageSubject = PublishSubject<UIImage?>()
    private var urlString: BehaviorRelay<String> = BehaviorRelay(value: "")
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
    
    func updateUrl(string: String?) {
        if let url = string {
            urlString.accept(url)
        } else {
            imageSubject.onNext(UIImage(named: "default.png"))
        }
    }
    
    //MARK: Private
    
    private func bindUI() {
        urlString.asObservable()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
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
