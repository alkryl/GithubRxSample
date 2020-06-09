//
//  CommitCell.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 05/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CommitCell: UITableViewCell {

    static let cellID = "CommitCell"
    static let cellHeight: CGFloat = 66.0
    
    private let db = DisposeBag()
    
    //MARK: Outlets
    
    @IBOutlet weak var messageLabel: MessageLabel!
    @IBOutlet weak var authorImageView: AuthorImageView!
    @IBOutlet weak var loginLabel: AuthorLoginLabel!
    @IBOutlet weak var dateLabel: DateLabel!
    @IBOutlet weak var hashLabel: HashLabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //MARK: Methods
    
    func configure(with model: Item) {
        bindSpinner()
        messageLabel.message.accept(model.commit.message)
        loginLabel.login.accept(model.author?.login)
        dateLabel.date.accept(model.commit.author.date)
        hashLabel.commitHash.accept(model.hash)
        authorImageView.updateUrl(string: model.author?.avatar)
    }
    
    //MARK: Private
    
    private func bindSpinner() {
        authorImageView.imageSubject.asObservable()
            .map { _ in false }
            .bind(to: spinner.rx.isAnimating)
            .disposed(by: db)
    }
}
