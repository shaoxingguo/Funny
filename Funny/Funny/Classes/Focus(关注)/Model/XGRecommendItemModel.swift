//
//  XGRecommendItemModel.swift
//  Funny
//
//  Created by monkey on 2019/3/16.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

@objcMembers class XGRecommendItemModel: NSObject
{
    /// 粉丝数
    var fansCount:Int = 0
    /// 头像
    var header:String?
    /// 昵称
    var screenName:String?
}

// MARK: - MJExtension

extension XGRecommendItemModel
{
    override class func mj_replacedKey(fromPropertyName121 propertyName: String!) -> Any! {
        return (propertyName as NSString).mj_underlineFromCamel()
    }
}
