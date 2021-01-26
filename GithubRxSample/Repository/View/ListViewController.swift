//
//  ListViewController.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 26/05/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class ListViewController: UIViewController {
        
    private var navigator: Navigator!
    private var viewModel: ListViewModel!
    
    static func createWith(navigator: Navigator,
                           storyboard: UIStoryboard,
                           viewModel: ListViewModel) -> ListViewController {
        let vc = storyboard.instantiateViewController(ofType: ListViewController.self)
        vc.navigator = navigator
        vc.viewModel = viewModel
        return vc
    }
    
    //MARK: Rx
    
    private let db = DisposeBag()
    
    private lazy var dataSource: RxTableViewSectionedReloadDataSource<RepositorySection> = {
        return RxTableViewSectionedReloadDataSource<RepositorySection>(
            configureCell: { [weak self] _, tableView, path, item in
                let item: Repository = item
                guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.repositoryCell, for: path)
                else {
                    self?.viewModel.showError(.dequeue(reason: Text.dequeueError))
                    return UITableViewCell()
                }
                cell.viewModel = RepoCellViewModel(item)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar(false)
        hideBackButtonText()
    }
    
    //MARK: Private
    
    private func prepareTableView() {
        tableView.backgroundView = indicator
        tableView.register(R.nib.repositoryCell)
    }
    
    private func updateUI(with count: Int) {
        tableView.separatorStyle = .singleLine
        navigationItem.title = "\(count) " + Text.repositories
        indicator.stop()
    }
}

//MARK: UITableViewDelegate

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RepositoryCell.height
    }
}

//MARK: Subscriber

extension ListViewController: Subscriber {
    func subscribe() {
        tableView.rx.setDelegate(self).disposed(by: db)
        
        viewModel.dataSections
            .skip(1)
            .do(onNext: { [weak self] sections in
                self?.updateUI(with: (sections.first?.items.count).orEmpty)
            })
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: db)
        
        let countObservable = viewModel.dataSections.map{ ($0.first?.items.count).orEmpty }
        let displayCellObservable = tableView.rx.willDisplayCell.map { $1.row }
        
        Observable.combineLatest(countObservable, displayCellObservable)
            .filter { $0 - 1 == $1 }
            .map { $1 }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.updatePage()
            }).disposed(by: db)
        
        tableView.rx.itemSelected
            .do(onNext: { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            }).subscribe(onNext: { [weak self] in
                self?.viewModel.updatePath($0)
            }).disposed(by: db)
        
        viewModel.selectedIndexPath.asDriver()
            .skip(1)
            .do(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.navigator.show(.description(self.viewModel.repositoryName), sender: self)
            }).drive()
            .disposed(by: db)
        
        viewModel.errorSubject
            .map { err -> String in
                if case let .obtaining(reason) = err {
                    return reason
                }
                return err.localizedDescription
            }
            .flatMap { [weak self] reason -> Observable<Void> in
                guard let self = self else { return Observable.empty() }
                return self.showAlert(title: Text.error, description: reason)
            }.subscribe()
            .disposed(by: db)
    }
}
