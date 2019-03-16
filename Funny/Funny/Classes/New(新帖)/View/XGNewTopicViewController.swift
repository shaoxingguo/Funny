//
//  XGNewViewController.swift
//  Funny
//
//  Created by monkey on 2019/3/11.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGNewTopicViewController: XGTopicTableViewController
{
    override var topicType: XGTopicType {
        return .All
    }
    
    override var isNewTopicList: Bool {
        return true
    }
    
    // MARK: - 控制器生命周期方法
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // 设置导航栏
        setUpNavigationItem()
    }
    
    // MARK: - 事件监听
    
    @objc private func pushToNewTopicRecommendTableViewControllerAction() -> Void
    {
        navigationController?.pushViewController(XGNewTopicRecommendTableViewController(), animated: true)
    }
}

// MARK: - 其他方法

extension XGNewTopicViewController
{
    /// 设置导航栏
    private func setUpNavigationItem()  -> Void
    {
        let button = UIButton(imageName: "MainTagSubIcon", target: self, action: #selector(pushToNewTopicRecommendTableViewControllerAction))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
}
