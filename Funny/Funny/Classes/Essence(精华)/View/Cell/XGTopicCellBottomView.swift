//
//  XGTopicCellBottomView.swift
//  Funny
//
//  Created by monkey on 2019/3/12.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGTopicCellBottomView: UIView
{
    // MARK: - 视图模型
    
    open var topicViewModel:XGTopicViewModel? {
        didSet {
            likeButton.setTitle(topicViewModel?.likeStr, for: .normal)
            unlikeButton.setTitle(topicViewModel?.unlikeStr, for: .normal)
            shareButton.setTitle(topicViewModel?.shareStr, for: .normal)
            commentButton.setTitle(topicViewModel?.commentStr, for: .normal)
        }
    }
    
    // MARK: - 私有属性
    
    /// 赞按钮
    @IBOutlet private weak var likeButton: UIButton!
    /// 踩按钮
    @IBOutlet private weak var unlikeButton: UIButton!
    /// 分享按钮
    @IBOutlet private weak var shareButton: UIButton!
    /// 评论按钮
    @IBOutlet private weak var commentButton: UIButton!
}

// MARK: - 其他方法

extension XGTopicCellBottomView
{
    /// xib创建对象方法
    open class func topicCellBottomView() -> XGTopicCellBottomView
    {
        return Bundle.main.loadNibNamed("XGTopicCellBottomView", owner: nil, options: nil)?.last as! XGTopicCellBottomView
    }
}
