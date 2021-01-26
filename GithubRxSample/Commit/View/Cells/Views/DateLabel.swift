//
//  DateLabel.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 08/06/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit

class DateLabel: UILabel, ViewUpdater {
    
    //MARK: ViewUpdater
    
    func update(with commitDate: AnyHashable) {
        guard let date = formattedDate(from: commitDate as! String) else {
            text = .empty
            return
        }
        text = Text.commit + date
    }
    
    //MARK: Private
    
    private func formattedDate(from date: String) -> String? {
        let getFormatter = DateFormatter()
        getFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = getFormatter.date(from: String(date.prefix(10))) else {
            return .empty
        }
        
        let outFormatter = DateFormatter()
        outFormatter.dateFormat = "dd MMM yyyy"
        return outFormatter.string(from: date)
    }
}
