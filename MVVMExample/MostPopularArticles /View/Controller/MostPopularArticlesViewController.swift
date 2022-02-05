//
//  MostPopularArticlesViewController.swift
//  MVVMExample
//
//  Created by Mac on 1/31/22.
//

import UIKit
import RxSwift
import RxCocoa

class MostPopularArticlesViewController: UIViewController {
    
    // MARK: - outlet
    @IBOutlet weak var articleTableView: UITableView!
    let refreshControl = UIRefreshControl()
    
    //MARK: - view model
    var articlesViewModel=MostPopularArticlesViewModel()
            
    //MARK: -viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.articleTableView.dataSource=self
        self.articleTableView.delegate=self
        setupTableView()
        getArticls()
    }
    
    //MARK: - setup tableView
    func setupTableView()
    {
        articleTableView.register(UINib(nibName:MostPopularArticlesTableViewCell.mostPopularArticlesTableViewCell , bundle: nil), forCellReuseIdentifier: MostPopularArticlesTableViewCell.mostPopularArticlesTableViewCell)
        refreshControl.addTarget(self, action: #selector(self.refreshTable(_:)), for: .valueChanged)
        articleTableView.addSubview(refreshControl)
    }
    
    // pull to refresh table view
    @objc func refreshTable(_ sender: AnyObject) {
        getArticls()
    }
    
    //MARK: - Api call and response
    // get Articls
    func getArticls()
    {
        articlesViewModel.startLoading={
            self.showIndicator(withTitle: "Loading ...", and: "")
        }
        articlesViewModel.endLoading={
            self.hideIndicator()
            self.refreshControl.endRefreshing()
        }
        articlesViewModel.getError={ error_msg in
            AlertMessages.showMessage(title: "Error", body: error_msg, theme: .error)
        }
        articlesViewModel.getData={
            self.articleTableView.reloadData()
        }
        articlesViewModel.getArticlesData(url: articlesViewModel.url)
    }
    
    
    //MARK: prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "showArticle")
        {
            let vc:ArticleDetailsViewController=segue.destination as! ArticleDetailsViewController
            vc.viewModel=sender as? DataListCellViewModel
        }
    }
}

extension MostPopularArticlesViewController:UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articlesViewModel.cell_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MostPopularArticlesTableViewCell=tableView.dequeueReusableCell(withIdentifier: MostPopularArticlesTableViewCell.mostPopularArticlesTableViewCell) as! MostPopularArticlesTableViewCell
        cell.cellConfigration(article: articlesViewModel.getCellModel(index: indexPath.row))
        return cell
    }
    
    
}

extension MostPopularArticlesViewController:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "showArticle", sender: articlesViewModel.getCellModel(index: indexPath.row))
    }
}

extension MostPopularArticlesViewController:ArticleViewModelDelegete
{
    func getError(error: String) {
        AlertMessages.showMessage(title: "Error", body: error, theme: .error)

    }
    
    func getData() {
        self.articleTableView.reloadData()
    }
    
    func startLoading() {
        self.showIndicator(withTitle: "Loading ...", and: "")
    }
    
    func endLoading() {
        self.hideIndicator()
        self.refreshControl.endRefreshing()
    }
    
    
}
