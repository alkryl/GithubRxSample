//
//  DescriptionViewController.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 26/05/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DescriptionViewController: UIViewController {
    
    private var navigator: Navigator!
    private var viewModel: DescriptionViewModel!
    private let db = DisposeBag()
    
    static func createWith(navigator: Navigator,
                           storyboard: UIStoryboard,
                           viewModel: DescriptionViewModel) -> DescriptionViewController {
        let vc = storyboard.instantiateViewController(ofType: DescriptionViewController.self)
        vc.navigator = navigator
        vc.viewModel = viewModel
        return vc
    }
    
    //MARK: Views

    @IBOutlet weak var tableView: UITableView!
    private let indicator = Indicator(style: .medium)
    
    //MARK: ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        bindUI()
    }
        
    //MARK: Private
    
    private func prepareTableView() {
        tableView.backgroundView = indicator
        tableView.register(UINib(nibName: CommitCell.cellID, bundle: Bundle.main),
                           forCellReuseIdentifier: CommitCell.cellID)
    }
    
    private func bindUI() {
        viewModel.tableData
            .map { _ in false }
            .drive(indicator.rx.isAnimating)
            .disposed(by: db)
        
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: db)
        
        tableView.rx.setDelegate(self).disposed(by: db)
        
        viewModel.tableData
            .do(onNext: { [unowned self] _ in
                self.tableView.separatorStyle = .singleLine
            }).drive(tableView.rx.items(cellIdentifier: CommitCell.cellID,
                                        cellType: CommitCell.self)) { _, model, cell in
                cell.viewModel.onNext(CommitCellViewModel(model))
            }.disposed(by: db)
        
        tableView.rx.itemSelected
            .do(onNext: { [unowned self] indexPath in
                self.tableView.deselectRow(at: indexPath, animated: true)
            }).subscribe(onNext: { [unowned self] indexPath in
                self.viewModel.updatePath(indexPath)
            })
            .disposed(by: db)
        
        viewModel.hash
            .do(onNext: { [unowned self] (hash) in
                self.showCodeOnGithub(with: hash)
            }).subscribe()
            .disposed(by: db)
    }
    
    private func showCodeOnGithub(with hash: String) {
        showAlert(title: "Show on Github?", description: nil) { [unowned self] in
            self.navigator.show(.code(self.viewModel.repoName, hash), sender: self)
        }.subscribe()
        .disposed(by: db)
    }
}

extension DescriptionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CommitCell.cellHeight
    }
}
