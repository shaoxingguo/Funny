//
//  XGNewTopicRecommendModel.swift
//  Funny
//
//  Created by monkey on 2019/3/13.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

@objcMembers class XGNewTopicRecommendModel: NSObject
{
    /// 头像
    var imageList:String?
    /// 关注数量
    var subNumber:Int = 0
    /// 名称
    var themeName:String?
}

// MARK: - MJExtension

extension XGNewTopicRecommendModel
{
    override class func mj_replacedKey(fromPropertyName121 propertyName: String!) -> Any! {
        return (propertyName as NSString).mj_underlineFromCamel()
    }
}
