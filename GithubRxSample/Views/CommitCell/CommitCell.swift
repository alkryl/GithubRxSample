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
        
    //MARK: Outlets
    
    @IBOutlet weak var messageLabel: MessageLabel!
    @IBOutlet weak var authorImageView: AuthorImageView!
    @IBOutlet weak var loginLabel: AuthorLoginLabel!
    @IBOutlet weak var dateLabel: DateLabel!
    @IBOutlet weak var hashLabel: HashLabel!
    
    //MARK: Instances
    
    private let db = DisposeBag()
    var viewModel = PublishSubject<CommitCellViewModel>()
    
    //MARK: Initialization
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewModel
            .subscribe(onNext: { [unowned self] (viewModel) in
                self.updateUI(viewModel.commit)
            }).disposed(by: db)
    }
        
    //MARK: Private
    
    private func updateUI(_ commit: Item) {
        messageLabel.message.accept(commit.commit.message)
        loginLabel.login.accept(commit.author?.login)
        dateLabel.date.accept(commit.commit.author.date)
        hashLabel.commitHash.accept(commit.hash)
        authorImageView.updateUrl(string: commit.author?.avatar)
    }
}
