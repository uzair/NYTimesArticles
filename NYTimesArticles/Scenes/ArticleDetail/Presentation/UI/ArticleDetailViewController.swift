//
//  ArticleDetailViewController.swift
//  NYTimesArticles
//
//  Created by Macbook on 15/02/2024.
//

import UIKit
import WebKit

class ArticleDetailViewController: UIViewController {
    
    @IBOutlet private weak var webView: WKWebView!
    
    var viewModel: ArticleDetailViewModelContractor?
    init(viewModel: ArticleDetailViewModelContractor) {
          self.viewModel = viewModel
          super.init(nibName: "ArticleDetailViewController", bundle: nil)
      }

      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupWebView()
        bindViewModel()
        viewModel?.onViewLoad()
    }

    private func bindViewModel() {
        viewModel?.viewState.bind(listener: { [weak self] (viewState) in
            self?.onViewStateChange(newState: viewState)
        })
    }
    
    private func setupWebView() {
        self.webView.allowsLinkPreview = true
        self.webView.navigationDelegate = self
    }
    
    private func onViewStateChange(newState: ArticleDetailViewState) {
        
        switch newState {
        case .idle:
            return
        case .loadingUrl(let urlString):
            if let urlString = urlString , let url = URL(string: urlString) {
                Utility.addActivityIndicator(toView: self.view)
                self.webView.load(URLRequest(url: url))
            }
        }
    }
}

extension ArticleDetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Web view finished loading content
        Utility.removeActivityIndicator(fromView: self.view)
        
    }
}

