//
//  ArticleListViewController.swift
//  NYTimesArticles
//
//  Created by Macbook on 15/02/2024.
//

import UIKit

class ArticleListViewController: UIViewController {
    
    private let viewModel: ArticleListViewModelContractor
    @IBOutlet private weak var tableView: UITableView!
    
    init(viewModel: ArticleListViewModelContractor) {
        self.viewModel = viewModel
        super.init(nibName: "ArticleListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupTableView()
        bindViewModel()
        viewModel.onViewLoad()
    }
    
    private func setupTableView() {
        
        tableView.estimatedRowHeight = 88
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "ArticleCell",
                                 bundle: nil),
                           forCellReuseIdentifier: "ArticleCell")
    }
    
    
    private func bindViewModel() {
        viewModel.viewState.bind(listener: { [weak self] (viewState) in
            self?.onViewStateChange(newState: viewState)
        })
    }
    
    private func onViewStateChange(newState: ArticleListViewState) {
        Utility.removeActivityIndicator(fromView: self.view)
        switch newState {
        case .idle:
            return
        case .loading:
            Utility.addActivityIndicator(toView: self.view)
        case .listingArticles:
            self.title = self.viewModel.listDisplayItem?.title
            self.tableView.reloadData()
            
        case .error(let error):
            self.showAlert(title: "Error", message:error.errorDescription )
        }
    }
}

extension ArticleListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.listDisplayItem?.cellDisplayItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleCell,
              let cellDisplayItem = self.viewModel.listDisplayItem?.cellDisplayItems?[indexPath.row]  else {
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
        self.viewModel.onClickListItemAt(index: indexPath.row)
    }
}
