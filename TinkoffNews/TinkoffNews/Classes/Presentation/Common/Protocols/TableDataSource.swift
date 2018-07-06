//
//  TableDataSource.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 30.06.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

protocol TableDataSource {
    func getCellViewModel(at row: Int) -> CellViewModel
    func getRowsCount() -> Int
}
