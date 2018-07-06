//
//  ConfigurableCell.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 30.06.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

protocol ConfigurableCell: class {
    func configure(_ viewModel: CellViewModel)
}
