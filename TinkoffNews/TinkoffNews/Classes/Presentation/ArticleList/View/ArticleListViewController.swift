//
//  ArticleListViewController.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 30.06.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

import UIKit

class ArticleListViewController: UIViewController, ServiceErrorPresentable {
    
    var viewModel: ArticleListViewModel!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomActivityIndicator: UIActivityIndicatorView!
    
    var loadMoreTransactionFlag: Bool = false
    
    var topRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView?.isHidden = true
        tableView.addSubview(topRefreshControl)
        configureViewModel()
        viewModel.initLoading()
    }
    
    //MARK: Setup
    
    func configureViewModel() {
        
        viewModel.onLoadingStatusUpdate = { [unowned self] (isLoading: Bool) in
            self.didUpdateLoadingStatus(isLoading)
        }
        
        viewModel.onErrorRecieve = { [unowned self] (error: ServiceError) in
            self.topRefreshControl.endRefreshing()
            self.showAlert(error: error)
        }
        
        viewModel.onItemsUpdate = { [unowned self] in
            self.tableView.reloadData()
        }
    }
    
    //MARK: Layout
    
    func didUpdateLoadingStatus(_ isLoading: Bool) {
        if isLoading {
            topRefreshControl.beginRefreshing()
        } else {
            topRefreshControl.endRefreshing()
            bottomActivityIndicator.stopAnimating()
            tableView.tableFooterView?.isHidden = true
            loadMoreTransactionFlag = false
        }
    }
    
    @objc func handleRefresh() {
        viewModel.updateArticles()
    }
    
    //MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destination = segue.destination as? ArticleDetailsViewController,
            let row = tableView.indexPathForSelectedRow?.row
        else {
            return
        }
        destination.articleDetailsIdentifier = viewModel.getDetailsIdentifier(row)
        destination.onDetailsSuccessPresenting = {
            self.viewModel.detailsSuccessPresenting(row)
        }
    }
    
    //MARK: Private
    
    fileprivate func loadMore() {
        guard !loadMoreTransactionFlag else {
            return
        }
        loadMoreTransactionFlag = true
        bottomActivityIndicator.startAnimating()
        tableView.tableFooterView?.isHidden = false
        viewModel.loadNextArticlesBatch()
    }
}

extension ArticleListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRowsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel: CellViewModel = viewModel.getCellViewModel(at: indexPath.row)
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: type(of: cellViewModel).cellIdentifier , for: indexPath)
        
        let configurableCell = cell as? ConfigurableCell
        configurableCell?.configure(cellViewModel)
        
        return cell
    }
}

extension ArticleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ArticleListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        
        if deltaOffset <= 0 {
            loadMore()
        }
    }
}


