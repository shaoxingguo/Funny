//
//  XGAllTableViewController.swift
//  Funny
//
//  Created by monkey on 2019/3/11.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

/// cell重用标识符
private let kReuseIdentifier = "XGTopicTableViewCell"

class XGAllTableViewController: UITableViewController
{

    /// 帖子视图模型
    private lazy var topicListViewModel = XGTopicListViewModel()
    
    // MARK: - 控制器生命周期方法
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        setUpTableView()
        loadData()
    }
}

// MARK: - 其他方法

private extension XGAllTableViewController
{
    /// 设置tableView
    func setUpTableView() -> Void
    {
        tableView.register(XGTopicTableViewCell.self, forCellReuseIdentifier: kReuseIdentifier)
        tableView.rowHeight = 150
        tableView.separatorStyle = .none
    }
}

// MARK: - 加载数据相关

private extension XGAllTableViewController
{
    /// 加载数据
    func loadData() -> Void
    {
        topicListViewModel.loadTopicList(type: .All) { (isSuccess) in
            if !isSuccess {
                XGPrint("加载自定义帖子失败")
                return
            }
            
            // 刷新表格
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource

extension XGAllTableViewController
{
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return topicListViewModel.topicList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: kReuseIdentifier) as! XGTopicTableViewCell
        cell.topicViewModel = topicListViewModel.topicList[indexPath.row]
        return cell
    }
}
