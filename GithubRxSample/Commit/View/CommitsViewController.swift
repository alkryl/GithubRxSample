//
//  CommitsViewController.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 26/05/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class CommitsViewController: UIViewController {
    
    var viewModel: CommitsViewModel!
    var showCodeAction: ((String, String) -> ())?
    var dismissAction: (() -> ())?
    
    //MARK: Rx
    
    private let db = DisposeBag()
    
    private lazy var dataSource: RxTableViewSectionedReloadDataSource<CommitSection> = {
        return RxTableViewSectionedReloadDataSource<CommitSection>(
            configureCell: { [weak self] _, tableView, path, item in
                let item: CommitItem = item
                guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.commitCell, for: path)
                else {
                    self?.viewModel.showError(.dequeue(reason: Text.dequeueError))
                    return UITableViewCell()
                }
                cell.viewModel = CommitCellViewModel(item)
                return cell
        })
    }()
    
    //MARK: Views

    @IBOutlet private weak var tableView: UITableView!
    private let indicator = Indicator(style: .medium)
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        subscribe()
    }
    
    //MARK: Transitioning
    
    override func didMove(toParent parent: UIViewController?) {
        if parent == nil {
            dismissAction?()
        }
    }
        
    //MARK: Private
    
    private func prepareTableView() {
        tableView.backgroundView = indicator
        tableView.register(R.nib.commitCell)
    }
    
    private func updateUI() {
        tableView.separatorStyle = .singleLine
        indicator.stop()
    }
}

//MARK: UITableViewDelegate

extension CommitsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CommitCell.height
    }
}

//MARK: Subscriber

extension CommitsViewController: Subscriber {
    func subscribe() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: db)
        
        tableView.rx.setDelegate(self).disposed(by: db)
        
        viewModel.dataSections
            .skip(1)
            .do(onNext: { [weak self] _ in
                self?.updateUI()
            })
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: db)
        
        tableView.rx.itemSelected
            .do(onNext: { [weak self] path in
                self?.tableView.deselectRow(at: path, animated: true)
            })
            .subscribe(onNext: { [weak self] path in
                self?.viewModel.updatePath(path)
            })
            .disposed(by: db)
        
        viewModel.hashSubject
            .do(onNext: { [weak self] hash in
                guard let self = self else { return }
                let name = self.viewModel.repository
                self.showCodeAction?(name, hash)
            }).subscribe()
            .disposed(by: db)
    }
}
