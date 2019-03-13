//
//  XGTopicCellTopView.swift
//  Funny
//
//  Created by monkey on 2019/3/12.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGTopicCellTopView: UIView
{
    // MARK: - 视图模型
    
    open var topicViewModel:XGTopicViewModel? {
        didSet {
            XGImageCacheManager.shared.imageForKey(key: topicViewModel?.profileImage, size: CGSize(width: kTopicCellUserIconWidth, height: kTopicCellUserIconWidth), backgroundColor: backgroundColor ?? UIColor.white, isUserIcon: true) { (image) in
                self.userIconImageView.image = image
            }
            
            userNameLabel.text = topicViewModel?.name
            createTimeLabel.text = topicViewModel?.passtime
        }
    }
    
    // MARK: - 私有属性
    
    /// 用户头像
    @IBOutlet private weak var userIconImageView: UIImageView!
    /// 用户昵称
    @IBOutlet private weak var userNameLabel: UILabel!
    /// 发布时间
    @IBOutlet private weak var createTimeLabel: UILabel!
}

// MARK: - 其他方法

extension XGTopicCellTopView
{
    /// xib创建对象方法
    open class func topicCellTopView() -> XGTopicCellTopView
    {
        return Bundle.main.loadNibNamed("XGTopicCellTopView", owner: nil, options: nil)?.last as! XGTopicCellTopView
    }
}

