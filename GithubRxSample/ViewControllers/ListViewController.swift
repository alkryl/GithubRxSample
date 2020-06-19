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

class ListViewController: UIViewController {
    
    private var navigator: Navigator!
    private var viewModel: ListViewModel!
    private let db = DisposeBag()
    
    static func createWith(navigator: Navigator,
                           storyboard: UIStoryboard,
                           viewModel: ListViewModel) -> ListViewController {
        let vc = storyboard.instantiateViewController(ofType: ListViewController.self)
        vc.navigator = navigator
        vc.viewModel = viewModel
        return vc
    }
    
    //MARK: Views

    @IBOutlet weak var tableView: UITableView!
    private let indicator = Indicator(style: .medium)
    
    //MARK: ViewController lifecycle
    
    //TODO: Fix warning on iOS 13 - UITableViewAlertForLayoutOutsideViewHierarchy
    /* Rx calls layoutIfNeeded() inside of viewDidLoad()
       https://github.com/ReactiveX/RxSwift/pull/2076
       tableView's fix will be out on the next release */

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        bindUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: Private
    
    private func prepareTableView() {
        tableView.backgroundView = indicator
        tableView.register(UINib(nibName: RepositoryCell.cellID, bundle: Bundle.main),
                           forCellReuseIdentifier: RepositoryCell.cellID)
    }
    
    private func bindUI() {
        viewModel.tableData
            .map { _ in false }
            .drive(indicator.rx.isAnimating)
            .disposed(by: db)
        
        viewModel.tableData
            .map { "\($0.count) repositories" }
            .drive(navigationItem.rx.title)
            .disposed(by: db)
        
        tableView.rx.setDelegate(self).disposed(by: db)
                        
        viewModel.tableData
            .do(onNext: { [unowned self] _ in
                self.tableView.separatorStyle = .singleLine
            })
            .drive(tableView.rx.items(cellIdentifier: RepositoryCell.cellID,
                                      cellType: RepositoryCell.self)) { _, model, cell in
                cell.viewModel.onNext(RepoCellViewModel(model))
            }.disposed(by: db)
                
        let countObservable = viewModel.tableData.asObservable().map { $0.count }
        let displayCellObservable = tableView.rx.willDisplayCell.map { $1.row }
        
        Observable.combineLatest(countObservable, displayCellObservable)
            .filter { $0 - 1 == $1 }
            .map { $1 }
            .distinctUntilChanged()
            .subscribe(onNext: { [unowned self] _ in
                self.viewModel.updatePage()
            }).disposed(by: db)
        
        tableView.rx.itemSelected
            .do(onNext: { [unowned self] indexPath in
                self.tableView.deselectRow(at: indexPath, animated: true)
            }).subscribe(onNext: { [unowned self] in
                self.viewModel.updatePath($0)
            }).disposed(by: db)
        
        viewModel.selectedIndexPath.asDriver()
            .skip(1)
            .do(onNext: { [unowned self] _ in
                self.navigator.show(.description(self.viewModel.repoName), sender: self)
            }).drive()
            .disposed(by: db)
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RepositoryCell.cellHeight
    }
}
