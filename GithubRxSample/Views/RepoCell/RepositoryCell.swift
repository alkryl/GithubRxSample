//
//  RepositoryCell.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 01/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RepositoryCell: UITableViewCell {
    
    static let cellID = "RepositoryCell"
    static let cellHeight: CGFloat = 98.0
    
    private let db = DisposeBag()
    
    //MARK: Outlets
    
    @IBOutlet weak var nameLabel: NameLabel!
    @IBOutlet weak var descriptionLabel: DescriptionLabel!
    @IBOutlet weak var avatarImageView: AvatarImageView!
    @IBOutlet weak var privateImageView: PrivateImageView!
    @IBOutlet weak var loginLabel: LoginLabel!
    @IBOutlet weak var languageView: LanguageCircleView!
    @IBOutlet weak var starsLabel: StarsLabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //MARK: Methods
    
    func configure(with model: Repository) {
        nameLabel.name.accept(model.name)
        descriptionLabel.descr.accept(model.description)
        avatarImageView.urlString.accept(model.owner.avatar)
        privateImageView.isPrivate.accept(model.private)
        loginLabel.login.accept(model.owner.login)
        languageView.language.accept(model.language)
        starsLabel.stars.accept(model.stars)
        bindSpinner()
    }
    
    //MARK: Private
    
    private func bindSpinner() {
        avatarImageView.imageSubject.asObservable()
            .map { _ in false }
            .bind(to: spinner.rx.isAnimating)
            .disposed(by: db)
    }
}
