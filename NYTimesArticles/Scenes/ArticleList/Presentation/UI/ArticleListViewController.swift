//
//  ArticleListViewController.swift
//  NYTimesArticles
//
//  Created by Macbook on 15/02/2024.
//

import UIKit

class ArticleListViewController: UIViewController {
    
    var viewModel: ArticleListViewModelContractor?
    private var listDisplayItem: ArticleListDisplayItem?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("I'm here")
        setupUI()
        bindViewModel()
        viewModel?.onViewLoad()
    }
    
    private func setupUI() {
        
    }
    
    private func bindViewModel() {
        viewModel?.viewState.bind(listener: { [weak self] (viewState) in
            self?.onViewStateChange(newState: viewState)
        })
    }

    private func onViewStateChange(newState: ArticleListViewState) {
        
        switch newState {
        case .idle:
            print(".idle")
        case .loading:
            print("loading")
        case .listingArticles(let articleListDisplayItem):
            self.listDisplayItem = articleListDisplayItem
            
        case .error(let string):
            print("error")
        }
    }


}
