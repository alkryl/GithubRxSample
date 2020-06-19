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
        
    //MARK: Outlets
    
    @IBOutlet weak var nameLabel: NameLabel!
    @IBOutlet weak var descriptionLabel: DescriptionLabel!
    @IBOutlet weak var avatarImageView: AvatarImageView!
    @IBOutlet weak var privateImageView: PrivateImageView!
    @IBOutlet weak var loginLabel: LoginLabel!
    @IBOutlet weak var languageView: LanguageCircleView!
    @IBOutlet weak var starsLabel: StarsLabel!
    
    //MARK: Instances
    
    private let db = DisposeBag()
    var viewModel = PublishSubject<RepoCellViewModel>()
    
    //MARK: Initialization
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewModel
            .subscribe(onNext: { [unowned self] viewModel in
                self.updateUI(viewModel.repo)
            }).disposed(by: db)
    }
    
    //MARK: Private
    
    private func updateUI(_ repository: Repository) {
        nameLabel.name.accept(repository.name)
        descriptionLabel.descr.accept(repository.description)
        avatarImageView.urlString.accept(repository.owner.avatar)
        privateImageView.isPrivate.accept(repository.private)
        loginLabel.login.accept(repository.owner.login)
        languageView.language.accept(repository.language)
        starsLabel.stars.accept(repository.stars)
    }
}
