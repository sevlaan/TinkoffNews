//
//  ArticleListCell.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 30.06.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

import UIKit

class ArticleListCell: UITableViewCell, ConfigurableCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    func configure(_ viewModel: CellViewModel) {
        guard let cellViewModel = viewModel as? ArticleListCellViewModel else {
            fatalError()
        }
        titleLabel.text = cellViewModel.title
        subtitleLabel.text = cellViewModel.createdDate
        let count = String(cellViewModel.viewsCount)
        countLabel.text = count
    }
}
