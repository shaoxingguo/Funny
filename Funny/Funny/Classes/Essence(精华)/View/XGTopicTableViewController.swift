//
//  XGTopicTableViewController.swift
//  Funny
//
//  Created by monkey on 2019/3/12.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGTopicTableViewController: UITableViewController
{
    /// 帖子视图模型
    private lazy var topicListViewModel = XGTopicListViewModel()
    
    // MARK: - 公开方法
    
    /// 帖子类型
    open var topicType:XGTopicType {
        return .All
    }
    
    /// cell重用标识符
    open var reuseIdentifier:String {
        return ""
    }
    
    /// 注册cell
    open func registerTableCell() -> Void
    {
        
    }
    
    // MARK: - 控制器生命周期方法
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setUpTableView()
        loadData()
    }
}

// MARK: - 其他方法

private extension XGTopicTableViewController
{
    /// 设置tableView
    func setUpTableView() -> Void
    {
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 400
        
        // 注册cell
        registerTableCell()
    }
}

// MARK: - 加载数据相关

private extension XGTopicTableViewController
{
    /// 加载数据
    func loadData() -> Void
    {
        topicListViewModel.loadTopicList(type: topicType) { (isSuccess) in
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

extension XGTopicTableViewController
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! XGBaseTopicTableViewCell
        cell.topicViewModel = topicListViewModel.topicList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return topicListViewModel.topicList[indexPath.row].rowHeight
    }
}
