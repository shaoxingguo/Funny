//
//  XGNewTopicRecommendTableViewController.swift
//  Funny
//
//  Created by monkey on 2019/3/13.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit
import SVProgressHUD

class XGNewTopicRecommendTableViewController: UITableViewController
{
    /// 推荐列表模型
    private lazy var newTopicRecommendListViewModel = XGNewTopicRecommendListViewModel()
    
    // MARK: - 控制器生命周期方法
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationItem.title = "热门推荐"
        loadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}

// MARK: - 其他方法

private extension XGNewTopicRecommendTableViewController
{
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
