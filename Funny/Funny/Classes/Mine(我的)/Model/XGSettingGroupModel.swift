//
//  XGSettingGroupModel.swift
//  Funny
//
//  Created by monkey on 2019/3/13.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit
import MJExtension

@objcMembers class XGSettingGroupModel: NSObject
{
    /// 组头标题
    var header:String?
    /// 组尾标题
    var footer:String?
    /// item数组
    var items:[XGSettingItemModel]?
}

// MARK: - MJExtension

extension XGSettingGroupModel
{
    override class func mj_objectClassInArray() -> [AnyHashable : Any]!
    {
        return ["items":XGSettingItemModel.self]
    }
}
