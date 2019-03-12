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
    
    /// 赞
    open var likeStr:String?
    /// 踩
    open var unlikeStr:String?
    /// 分享
    open var shareStr:String?
    /// 评论
    open var commentStr:String?
    
    // MARK: - 构造方法
    
    /// 帖子模型
    private var topicModel:XGTopicModel?
    
    init(model:XGTopicModel)
    {
        topicModel = model
        
        super.init()
        
        // 设置属性值
        likeStr = numberToString(number: topicModel?.ding ?? 0)
        unlikeStr = numberToString(number: topicModel?.cai ?? 0)
        shareStr = numberToString(number: topicModel?.repost ?? 0)
        commentStr = numberToString(number: topicModel?.comment ?? 0)
    }
}

// MARK: - 其他方法

private extension XGTopicViewModel
{
    
    /// 数字转换成字符串
    ///
    /// - Parameter number: 数字
    /// - Returns: 字符串
    func numberToString(number:Int) -> String?
    {
        
        var str:String
        if number < 10000 {
            str = "\(number)" // 小于1万
        } else {
            // 大于1万
            str = String(format: "%.2f", CGFloat(number) / CGFloat(10000))
            // 处理 2.00
            if str.hasSuffix(".00") {
                let location = (str as NSString).range(of: ".00").location
                str = (str as NSString).substring(to: location)
            } else if str.hasSuffix("0") {
                // 处理 2.20
                let index = str.index(str.endIndex, offsetBy: -1)
                str = String(str[..<index])
            }
            
            str += "万"
        }
        
        return str
    }
}
