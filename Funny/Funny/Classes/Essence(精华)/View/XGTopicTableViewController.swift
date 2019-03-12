//
//  XGTopicTableViewController.swift
//  Funny
//
//  Created by monkey on 2019/3/12.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

/// 视频cell重用标识符
public let kVideoTopicTableViewCellReuseIdentifier:String = "XGVideoTopicTableViewCell";
/// 声音cell重用标识符
public let kVoiceTopicTableViewCellReuseIdentifier:String = "XGVoiceTopicTableViewCell";
/// 图片cell重用标识符
public let kPictureTopicTableViewCellReuseIdentifier:String = "XGPictureTopicTableViewCell";
/// 段子cell重用标识符
public let kWordTopicTableViewCellReuseIdentifier:String = "XGWordTopicTableViewCell";

class XGTopicTableViewController: UITableViewController
{
    /// 帖子视图模型
    private lazy var topicListViewModel = XGTopicListViewModel()
    
    // MARK: - 公开方法
    
    /// 帖子类型
    open var topicType:XGTopicType {
        return .All
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
    
    /// 注册cell
    func registerTableCell() -> Void
    {
        tableView.register(XGPictureTopicTableViewCell.self, forCellReuseIdentifier: kPictureTopicTableViewCellReuseIdentifier)
        tableView.register(XGVideoTopicTableViewCell.self, forCellReuseIdentifier: kVideoTopicTableViewCellReuseIdentifier)
        tableView.register(XGVoiceTopicTableViewCell.self, forCellReuseIdentifier: kVoiceTopicTableViewCellReuseIdentifier)
        tableView.register(XGWordTopicTableViewCell.self, forCellReuseIdentifier: kWordTopicTableViewCellReuseIdentifier)
    }
    
    
    /// 根据视图模型返回对应的cell重用标识符
    ///
    /// - Parameter topicViewModel: 视图模型
    /// - Returns: cell重用标识符
    func reuseIdentifierWithTopicModel(topicViewModel:XGTopicViewModel) -> String
    {
        switch topicViewModel.type {
        case .Picture:
            return kPictureTopicTableViewCellReuseIdentifier
        case .Video:
            return kVideoTopicTableViewCellReuseIdentifier
        case .Voice:
            return kVoiceTopicTableViewCellReuseIdentifier
        case .Word:
            return kWordTopicTableViewCellReuseIdentifier
        case  .All:
            return kWordTopicTableViewCellReuseIdentifier
        }
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
        let topicViewModel = topicListViewModel.topicList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierWithTopicModel(topicViewModel: topicViewModel)) as! XGBaseTopicTableViewCell
        cell.topicViewModel = topicViewModel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return topicListViewModel.topicList[indexPath.row].rowHeight
    }
}
