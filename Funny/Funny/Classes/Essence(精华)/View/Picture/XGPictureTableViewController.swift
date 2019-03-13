//
//  XGPictureTableViewController.swift
//  Funny
//
//  Created by monkey on 2019/3/11.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGPictureTableViewController: XGTopicTableViewController
{
    override var topicType: XGTopicType {
        return .Picture
    }
    
    // MARK: - 控制器生命周期方法
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // 注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(pictureTopicCellImageTapNotification(notification:)), name: NSNotification.Name(rawValue: kPictureTopicCellImageTapNotification), object: nil)
    }
    
    deinit {
        // 注销通知
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - 通知监听
    
    @objc private func pictureTopicCellImageTapNotification(notification:Notification) -> Void
    {
        guard let topicViewModel = notification.object as? XGTopicViewModel else {
            return
        }
        
        let viewController = XGSeeBigPictureViewController(topicViewModel: topicViewModel)
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = transitionAnimation
        present(viewController, animated: true, completion: nil)
    }
    
    // MARK: - 私有属性
    /// 转场动画器
    private lazy var transitionAnimation = XGTransitionAnimation()
}
