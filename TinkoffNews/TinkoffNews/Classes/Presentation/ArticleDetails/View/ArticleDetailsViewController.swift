//
//  ArticleDetailsViewController.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 05.07.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

import UIKit
import WebKit

class ArticleDetailsViewController: UIViewController, ServiceErrorPresentable {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    
    var service: ArticleDetailsService!
    var articleDetailsIdentifier: String?
    var onDetailsSuccessPresenting: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        webView.addSubview(activityIndicator)
        presentData()
    }
    
    func presentData() {
        showLoader(true)
        guard let articleId = articleDetailsIdentifier else {
            fatalError("article identifier isn't injected")
        }
        if let articleDetails: ArticleDetails = service.getCachedArticleDetails(articleId) {
            webView.loadHTMLString(articleDetails.text, baseURL: nil)
        } else {
            service.getArticleDetails(articleId) { [weak  self] (articleDetails: ArticleDetails?, error: ServiceError?) in
                guard let `self` = self else { return }
                if let e = error {
                    self.showAlert(error: e)
                } else if let details = articleDetails {
                    self.webView.loadHTMLString(details.text, baseURL: nil)
                }
            }
        }
    }
    
    func showLoader(_ show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}

extension ArticleDetailsViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.showLoader(false)
        onDetailsSuccessPresenting?()
    }
}
