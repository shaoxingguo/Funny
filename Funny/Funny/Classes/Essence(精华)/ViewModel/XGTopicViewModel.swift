//
//  XGTopicViewModel.swift
//  Funny
//
//  Created by monkey on 2019/3/12.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

class XGTopicViewModel: NSObject
{
    /// 用户的名字
    open var name:String? {
        return topicModel?.name
    }
    
    /// 用户的头像
    open var profileImage:String? {
        return topicModel?.profileImage
    }
    
    /// 帖子的文字内容
    open var text:String? {
        return topicModel?.text
    }
    
    /// 帖子审核通过的时间
    open var passtime:String? {
        return topicModel?.passtime
    }
    
    // MARK: - 构造方法
    
    /// 帖子模型
    private var topicModel:XGTopicModel?
    
    init(model:XGTopicModel)
    {
        topicModel = model
        super.init()
    }
}
