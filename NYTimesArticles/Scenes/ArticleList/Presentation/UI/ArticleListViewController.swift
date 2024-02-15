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
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("I'm here")
        setupTableView()
        bindViewModel()
        viewModel?.onViewLoad()
    }
    
    private func setupTableView() {
        
            tableView.estimatedRowHeight = 88
            tableView.rowHeight = UITableView.automaticDimension
            tableView.register(UINib(nibName: "ArticleCell",
                                     bundle: nil),
                                    forCellReuseIdentifier: "ArticleCell")
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
            self.title = articleListDisplayItem.title
            self.tableView.reloadData()
            
        case .error(let string):
            print("error")
        }
    }
}


extension ArticleListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.listDisplayItem?.cellDisplayItems?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleCell,
              let cellDisplayItem = self.listDisplayItem?.cellDisplayItems?[indexPath.row]  else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.apply(model: cellDisplayItem)
        return cell
    }
    
}


extension ArticleListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    
    }

}
