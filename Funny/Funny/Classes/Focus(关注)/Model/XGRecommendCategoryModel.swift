//
//  XGFocusCategoryModel.swift
//  Funny
//
//  Created by monkey on 2019/3/15.
//  Copyright © 2019 itcast. All rights reserved.
//

import UIKit

@objcMembers class XGRecommendCategoryModel: NSObject
{
    /// 列表个数
    var count:Int = 0
    /// 分类ID
    var id:Int = 0
    /// 分类名称
    var name:String?
    /// 推荐标签数组
    var items = [XGRecommendItemModel]()
    /// 页码
    var page:Int = 0
    /// 总页码
    var totalPage:Int = 0
}
