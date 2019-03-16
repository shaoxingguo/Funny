//
//  XGAllTableViewController.swift
//  Funny
//
//  Created by monkey on 2019/3/11.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGAllTableViewController: XGTopicTableViewController
{
    override var topicType: XGTopicType {
        return .All
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // 注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(topicCellDidTapNotification(notification:)), name: NSNotification.Name(rawValue: kTopicCellDidTapNotification), object: nil)
    }
    
    deinit {
        // 注销通知
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - 通知监听
    
    @objc private func topicCellDidTapNotification(notification:Notification) -> Void
    {
        guard let topicViewModel = notification.userInfo?[kTopicViewModelKey] as? XGTopicViewModel,
              let type = notification.userInfo?[kTopicTypeKey] as? XGTopicType else {
                return
        }
        
        var viewController:UIViewController?
        
        switch type {
        case .Picture:
            viewController = XGSeeBigPictureViewController(topicViewModel: topicViewModel)
        case .Video:
            viewController = XGVideoPlayerViewController(topicViewModel: topicViewModel)
            break
        case .Voice:
            viewController = XGVoicePlayerViewController(topicViewModel: topicViewModel)
            break
        case .Word:
            break
        case .All:
            break
        }
        
        if let viewController = viewController {
            viewController.modalPresentationStyle = .custom
            viewController.transitioningDelegate = transitionAnimation
            present(viewController, animated: true, completion: nil)
        }
    }
    
    // MARK: - 私有属性
    
    /// 转场动画器
    private lazy var transitionAnimation = XGTransitionAnimation()
}
