//
//  RepositoryCell.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 01/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit

final class RepositoryCell: UITableViewCell {
    
    static let height: CGFloat = 98.0
        
    //MARK: Outlets
    
    @IBOutlet private var viewsCollection: [ViewUpdater]!
    
    //MARK: Properties
    
    var viewModel: RepoCellViewModel? {
        didSet {
            self.updateUI()
        }
    }
    
    //MARK: Private
    
    private func updateUI() {
        guard let vm = viewModel else { return }
        
        viewsCollection.forEach { view in
            if let value = vm.parameter(for: view.tag) {
                view.update(with: value)
            }
        }
    }
}
