//
//  XGNewTopicRecommendTableViewController.swift
//  Funny
//
//  Created by monkey on 2019/3/13.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit
import SVProgressHUD

/// cell重用标识符
private let kReuseIdentifier = "XGNewTopicRecommendTableViewCell"

class XGNewTopicRecommendTableViewController: UITableViewController
{
    /// 推荐列表模型
    private lazy var newTopicRecommendListViewModel = XGNewTopicRecommendListViewModel()
    
    // MARK: - 控制器生命周期方法
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setUpTableView()
        navigationItem.title = "热门推荐"
        loadData()
    }
}

// MARK: - UITableViewDataSource

extension XGNewTopicRecommendTableViewController
{
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return newTopicRecommendListViewModel.recommendList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: kReuseIdentifier) as! XGNewTopicRecommendTableViewCell
        cell.newTopicRecommendModel = newTopicRecommendListViewModel.recommendList[indexPath.row]
        return cell
    }
}

// MARK: - 其他方法

private extension XGNewTopicRecommendTableViewController
{
    /// 设置tableView
    func setUpTableView() -> Void
    {
        tableView.rowHeight = 60
        // 注册cell
        tableView.register(UINib(nibName: "XGNewTopicRecommendTableViewCell", bundle: nil), forCellReuseIdentifier: kReuseIdentifier)
    }
    
    /// 加载数据
    func loadData() -> Void
    {
        SVProgressHUD.show()
        newTopicRecommendListViewModel.loadNewTopicRecommendList { (isSuccess) in
            if !isSuccess {
                SVProgressHUD.dismiss()
                XGPrint("加载推荐列表失败")
                return
            }
            
            SVProgressHUD.dismiss()
            // 刷新表格
            self.tableView.reloadData()
        }
    }
}
