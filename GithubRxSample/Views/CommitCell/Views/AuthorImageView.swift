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
import RxKingfisher

@IBDesignable class AuthorImageView: UIImageView {

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
            image = UIImage(named: "default.png")
        }
    }
    
    //MARK: Private
    
    private func bindUI() {
        urlString.asObservable()
            .filter { !$0.isEmpty }
            .map { URL(string: $0) }
            .bind(to: (self as UIImageView).kf.rx.image(options: [.transition(.fade(0.2))]))
            .disposed(by: db)
    }
}
